# frozen_string_literal: true

require 'opencpu'
require 'quby/answers/entities/patient'

module Quby
  module Answers
    module Services
      class ScoreCalculator
        class UnknownFieldsReferenced < StandardError; end

        class MissingAnswerValues < StandardError
          attr_reader :questionnaire_key, :values, :missing

          def initialize(msg = nil, questionnaire_key:, values:, missing:)
            super(msg)
            @questionnaire_key = questionnaire_key
            @values = values
            @missing = missing
          end
        end

        # Evaluates block within the context of a new calculator
        # instance. All instance methods are accessible.
        def self.calculate(**kwargs, &block)
          instance = new(**kwargs)
          result = instance.instance_eval(&block)
          result = result.merge(referenced_values: instance.referenced_values) if result.respond_to?(:merge)
          result
        end

        # Public: Initialize a new ScoreCalculator
        #
        # values - The Hash values describes the keys of questions and the values
        #          of the answer given to that question.
        # timestamp - The Time to be used to calculate the age of the patient.
        # patient_attrs - A Hash describing extra patient information (default: {})
        #           :birthyear - The Integer birthyear of the patient to be used in
        #                        score calculation (optional)
        #           :gender - The Symbol gender of the patient, must be one of:
        #                     :male, :female or :unknown (optional)
        # respondent_attrs - A Hash describing respondent information (default: {})
        #           :respondent_type - The Symbol or String type of respondent
        def initialize(questionnaire:, values:, timestamp:, patient_attrs: {}, respondent_attrs: {})
          @questionnaire = questionnaire
          @values = values
          @timestamp = timestamp
          @patient = Entities::Patient.new(patient_attrs)
          @respondent = Entities::Respondent.new(respondent_attrs)
          @score = {}
          @referenced_values = []
        end

        # Public: Get values for given question keys
        #
        # *keys - A list or array of keys for which to return values
        #
        # Returns an Array of values. Values are whatever they may be defined as,
        # usually they are either Integers of Floats, but remember that no such
        # restriction is placed. And for open questions the value will probably
        # be a String.
        # Returns hash of all values if no keys are given.
        #
        # Raises MissingAnswerValues if one or more keys doesn't have a value.
        def values(*keys)
          keys = keys.flatten(1).map(&:to_s)
          ensure_answer_values_for(keys)
          values_with_nils(keys)
        end

        # Public: Get values for given question keys removing any missing keys.
        #
        # *keys - A list or array of keys for which to return values - required.
        # *minimum_present - see Raises.
        # *missing_values - extra values to consider missing.
        #
        # Returns an Array of values. Values are whatever they may be defined as,
        # usually they are either Integers of Floats, but remember that no such
        # restriction is placed. And for open questions the value will probably
        # be a String.
        #
        # Raises MissingAnswerValues when less than minimum_present keys have a value.
        def values_without_missings(*keys, minimum_present: 1, missing_values: [])
          keys = keys.flatten(1).map(&:to_s)
          fail ArgumentError, 'keys empty' unless keys.present?

          ensure_answer_values_for(keys, minimum_present: minimum_present, missing_values: missing_values)
          values_with_nils(keys).reject do |v|
            missing_value?(v, missing_values: missing_values)
          end
        end

        # Public: Get value for given question key
        #
        # key - A key for which to return a value
        #
        # Returns the value.
        #
        # Raises MissingAnswerValues if the keys doesn't have a value.
        def value(key)
          values(key).first
        end

        # Public: Get values for given question keys, or nil if the question is not filled in
        #
        # *keys - A list of keys for which to return values
        #
        # Returns an Array of values. Values are whatever they may be defined as,
        # usually they are either Integers of Floats, but remember that no such
        # restriction is placed. And for open questions the value will probably
        # be a String. If the question is not filled in or the question key is
        # unknown, nil will be returned for that question.
        def values_with_nils(*keys)
          keys = keys.flatten(1).map(&:to_s)
          ensure_defined_question_keys(keys)
          ensure_no_duplicate_keys(keys)

          if keys.empty?
            remember_usage_of_value_keys(@values.keys)
            @values
          else
            remember_usage_of_value_keys(keys)
            @values.values_at(*keys)
          end
        end

        # Public: Gives mean of values
        #
        # values - An Array of Numerics
        # ignoring - An array of values to remove before taking the mean.
        # minimum_present - return nil if less values than this are left after filtering
        #
        # Returns the mean of the given values or nil if minimum_present is not met.
        def mean(values, ignoring: [], minimum_present: 1)
          compacted_values = values.reject { |v| ignoring.include? v }
          return nil if compacted_values.blank? || compacted_values.length < minimum_present
          sum(compacted_values).to_f / compacted_values.length
        end

        # Public: Gives mean of values, ignoring nil values
        #
        # values - An Array of Numerics
        #
        # Returns the mean of the given values
        def mean_ignoring_nils(values)
          mean(values, ignoring: [nil])
        end

        # Public: Gives mean of values, ignoring nil values if >= 80% is filled in
        #
        # values - An Array of Numerics
        #
        # Returns the mean of the given values, or nil if less than 80% is present
        def mean_ignoring_nils_80_pct(values)
          mean(values, ignoring: [nil], minimum_present: values.length * 0.8)
        end

        # Public: Sums values, extrapolating nils to be valued as the mean of the present values
        #
        # values - An Array of Numerics
        # minimum_answered - The minimum of values needed to be present, returns nil otherwise
        #
        # Returns the sum of the given values, or nil if minimum_present is not met
        def sum_extrapolate(values, minimum_present)
          return nil if values.reject(&:blank?).length < minimum_present
          mean = mean_ignoring_nils(values)
          values = values.map { |value| value ? value : mean }
          sum(values)
        end

        # Public: Sums values, extrapolating nils to be valued as the mean of the present values
        #
        # values - An Array of Numerics
        #
        # Returns the sum of the given values, or nil if less than 80% is present
        def sum_extrapolate_80_pct(values)
          sum_extrapolate(values, values.length * 0.8)
        end

        # Public: Sums values
        #
        # values - An Array of Numerics
        #
        # Returns the sum of the given values
        def sum(values)
          values.reduce(0, &:+)
        end

        # Public: Max of values
        #
        # values - an Array or list of Numerics
        #
        # Returns the highest value of the given values
        def max(*values)
          values.flatten.compact.max
        end

        # Public: Returns the Integer age of the patient, or nil if it's not known.
        def age
          @patient.age_at @timestamp
        end

        # Public: Returns the Symbol describing the gender of the patient.
        #
        # The symbol :unknown is returned when gender is not known.
        def gender
          @patient.gender
        end

        # Public: Returns the type of the respondent
        def respondent_type
          @respondent.type
        end

        # Public: Runs another score calculation or variable and returns its result
        #
        # key - The Symbol of another score.
        def score(key)
          fail "Score #{key.inspect} does not exist." unless @questionnaire.score_calculations.key? key

          calculation = @questionnaire.score_calculations.fetch(key)
          instance_eval(&calculation.calculation)
        end

        def referenced_values
          @values.keys.select { |key| @referenced_values.include? key }
        end

        def opencpu(package, function, parameters = {})
          client = ::OpenCPU.client
          client.execute(package, function, parameters)
        end

        def table_lookup(table_key, parameters)
          @questionnaire.lookup_tables.fetch(table_key).lookup(parameters)
        end

        # Public: Ensure given question_keys have answers. Strings with nothing but whitespace are
        # not considered answered.
        #
        # *keys - A list of keys to check if an answer is given
        # *minimum_present - defaults to all
        # *missing_values - extra values to consider missing.
        def ensure_answer_values_for(*keys, minimum_present: keys.flatten(1).size, missing_values: [])
          keys = keys.flatten(1).map(&:to_s)
          # we also consider '' and whitespace to be not filled in, as well as nil values or missing keys
          unanswered_keys = keys.select { |key| missing_value?(@values[key], missing_values: missing_values) }

          if unanswered_keys.size > keys.size - minimum_present
            raise MissingAnswerValues.new \
                    questionnaire_key: @questionnaire.key,
                    values: @values,
                    missing: unanswered_keys
          end
        end

        private

        def table_hash
          @table_hash ||= {}.with_indifferent_access
        end

        def remember_usage_of_value_keys(keys)
          @referenced_values += keys
        end

        def ensure_defined_question_keys(keys)
          unknown_keys = keys.reject { |key| @questionnaire.fields.key_in_use?(key) }

          if unknown_keys.present?
            fail UnknownFieldsReferenced, questionnaire_key: @questionnaire.key,
                                          unknown: unknown_keys
          end
        end

        def ensure_no_duplicate_keys(keys)
          fail ArgumentError, 'Key requested more than once' if keys.uniq!
        end

        def missing_value?(value, missing_values: [])
          value.blank? || missing_values.include?(value)
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'set'

module Quby
  module Compiler
    module Entities
      class Fields
        attr_reader :question_hash

        # hash of all options from input_key to the QuestionOption.
        # Used by including applications to lookup the definition of e.g. a check_box question.
        attr_reader :option_hash

        # An +answer_key+ is a key that will exist in the values hash of an answer. This means that answer keys for
        # radio's will be just the question key, and answer keys for checkboxes will be the keys of all the options.
        # These are the POST parameters when submitting the form, and so they must be globally unique or we won't know
        # which question the received data belongs to.
        attr_reader :answer_keys

        # An +input_key+ is a key that uniquely identifies a single <input> tag. For radios, every radio option will
        # have its own input key. This is needed because option keys must be globally unique so that they can be
        # targeted by :depends_on relations.
        attr_reader :input_keys

        def initialize(questionnaire)
          @question_hash = HashWithIndifferentAccess.new
          @option_hash   = HashWithIndifferentAccess.new
          @answer_keys   = Set.new
          @input_keys    = Set.new
          @questionnaire = questionnaire
        end

        def add(question)
          new_answer_keys = Set.new(question.answer_keys)
          new_input_keys  = Set.new(question.input_keys)

          # This is probably the best place to ensure that keys don't collide. However,our current set of questionnaires
          # does have a few collisions between +v_1+ option +a9+ and its subquestion +v_1_a9+, so we have excluded
          # those questionnaires from this check through @questionnaire.check_key_clashes.
          check_key_clashes(new_answer_keys, new_input_keys) if @questionnaire.check_key_clashes

          @question_hash[question.key] = question
          @input_keys.merge(new_input_keys)
          @answer_keys.merge(new_answer_keys)
          question.options.each do |option|
            @option_hash[option.input_key] = option
          end
        end

        def check_key_clashes(new_answer_keys, new_input_keys)
          if @answer_keys.intersect?(new_answer_keys)
            fail "Duplicate answer keys: #{@answer_keys.intersection(new_answer_keys).inspect}"
          end

          if @input_keys.intersect?(new_input_keys)
            fail "Duplicate input keys: #{@input_keys.intersection(new_input_keys).inspect}"
          end
        end

        def key_in_use?(key)
          @question_hash.key?(key) || input_keys.include?(key.to_sym)
        end

        # Given a list of question and option keys returns a list of input-keys. If a given key is a question-key,
        # adds the question.input_keys If a given key is an option-input-key it adds the given key. Raises an error
        # if a key is not defined.
        def expand_input_keys(keys)
          keys.reduce([]) do |ikeys, key|
            if question_hash.key?(key)
              ikeys += question_hash[key].input_keys
            elsif input_keys.include?(key.to_sym)
              ikeys << key
            else
              fail Entities::Questionnaire::UnknownInputKey, "Unknown input key #{key}"
            end
          end
        end

        # returns a human readable string description given a key of a question,
        # question component (date components, checkbox options), score, flag or textvar
        def description_for_variable(key)
          # for questionnaires where we do not check_key_clashes we cannot reliably retrace the variable keys,
          # since they contain conflicts between option keys and question keys
          # in order to be safe we return a string explaining the issue
          return "No description due to question/option key clash" if option_hash.key?(key) && question_hash.key?(key)

          variable_description(key)
        end

        def as_json
          question_hash
        end

        private

        # warning, will contain a result even if option/answer key clashes exist for a given key
        def variable_description(key)
          @question_variable_descriptions ||= @questionnaire.questions
                                                            .map(&:variable_descriptions)
                                                            .reduce({}, &:merge!)
          @question_variable_descriptions[key] ||
            score_descriptions[key] ||
            @questionnaire.flags[key]&.variable_description ||
            @questionnaire.textvars[key]&.description
        end

        def score_descriptions
          @score_variable_descriptions ||=
            @questionnaire.score_schemas.values.map do |score_schema|
              score_schema.subscore_schemas.map do |subschema|
                [subschema.export_key, "#{score_schema.label} #{subschema.label}"]
              end
            end.flatten(1).to_h.with_indifferent_access
        end
      end
    end
  end
end

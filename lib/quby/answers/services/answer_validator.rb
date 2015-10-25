# rubocop:disable LineLength

module Quby
  module Answers
    module Services
      class AnswerValidator
        class InvalidValue < StandardError; end

        attr_reader :questionnaire
        attr_reader :answer

        def initialize(questionnaire, answer)
          @questionnaire = questionnaire
          @answer        = answer
        end

        # rubocop:disable CyclomaticComplexity
        def validate
          return if answer.aborted

          questionnaire.questions.each do |question|
            next unless question
            next if question.hidden?

            if question.depends_on.present?
              next unless question.depends_on.any? { |key| depends_on_key_answered(key) }
            end

            value = answer.send(question.key)
            next if answer.skip_validation?(value, question)

            question.validations.each do |validation|
              begin
                case validation[:type]
                when :valid_integer
                  validate_integer(question, validation, value)
                when :valid_float
                  validate_float(question, validation, value)
                when :regexp
                  validate_regexp(question, validation, value)
                when :requires_answer
                  validate_required(question, validation, value)
                when :minimum
                  validate_minimum(question, validation, value)
                when :maximum
                  validate_maximum(question, validation, value)
                when :too_many_checked
                  validate_too_many_checked(question, validation, value)
                when :not_all_checked
                  validate_not_all_checked(question, validation, value)
                when :maximum_checked_allowed
                  validate_maximum_checked_allowed(question, validation, value)
                when :minimum_checked_required
                  validate_minimum_checked_required(question, validation, value)
                when :answer_group_minimum
                  validate_answer_group_minimum(question, validation, value)
                when :answer_group_maximum
                  validate_answer_group_maximum(question, validation, value)
                when :answer_group_require_all_or_none
                  validate_answer_group_require_all_or_none(question, validation, value)
                end
              rescue InvalidValue
                answer.send(:add_error, question, validation[:type], validation[:message] || "Invalid value.")
              end
            end
          end
        end
        # rubocop:enable CyclomaticComplexity

        def validate_required(question, validation, value)
          if question.type == :check_box && value.values.reduce(:+) == 0 || value.blank?
            answer.send(:add_error, question, validation[:type], validation[:message] || "Must be answered.")
          end
        end

        def validate_integer(question, validation, value)
          return if value.blank?
          Integer(value)
        rescue ArgumentError
          answer.send(:add_error, question, :valid_integer, validation[:message] || "Invalid integer")
        end

        def validate_float(question, validation, value)
          return if value.blank?
          Float(value)
        rescue ArgumentError
          answer.send(:add_error, question, :valid_float, validation[:message] || "Invalid float")
        end

        def validate_regexp(question, validation, value)
          return if value.blank?
          match = validation[:matcher].match(value)
          unless match && match[0] == value
            answer.send(:add_error, question, validation[:type], validation[:message] || "Does not match pattern expected.")
          end
        end

        def validate_minimum(question, validation, value)
          return if value.blank?
          converted_answer_value = convert_answer_value(question, value)
          if converted_answer_value < validation[:value]
            answer.send(:add_error, question, validation[:type], validation[:message] || "Smaller than minimum")
          end
        end

        def validate_maximum(question, validation, value)
          return if value.blank?
          converted_answer_value = convert_answer_value(question, value)
          if converted_answer_value > validation[:value]
            answer.send(:add_error, question, validation[:type], validation[:message] || "Exceeds maximum")
          end
        end

        def validate_too_many_checked(question, validation, value)
          if answer.send(question.uncheck_all_option) == 1 and value.values.reduce(:+) > 1
            answer.send(:add_error, question, :too_many_checked, validation[:message] || "Invalid combination of options.")
          end
        end

        def validate_not_all_checked(question, validation, value)
          if answer.send(question.check_all_option) == 1 and
              value.values.reduce(:+) < value.length - (question.uncheck_all_option ? 1 : 0)
            answer.send(:add_error, question, :not_all_checked, validation[:message] || "Invalid combination of options.")
          end
        end

        def validate_maximum_checked_allowed(question, validation, value)
          if value.values.reduce(:+) > question.maximum_checked_allowed.to_i
            answer.send(:add_error, question, :maximum_checked_allowed, validation[:message] || "Too many options checked.")
          end
        end

        def validate_minimum_checked_required(question, validation, value)
          if value.values.reduce(:+) < question.minimum_checked_required.to_i
            answer.send(:add_error, question, :minimum_checked_required, validation[:message] || "Not enough options checked.")
          end
        end

        def validate_answer_group_minimum(question, validation, value)
          answered = answer.send(:calc_answered, answer.question_groups[validation[:group]])
          if answered < validation[:value]
            answer.send(:add_error, question, :answer_group_minimum,
                        validation[:message] || "Needs at least #{validation[:value]} question(s) answered.")
          end
        end

        def validate_answer_group_maximum(question, validation, value)
          answered = answer.send(:calc_answered, answer.question_groups[validation[:group]])
          if answered > validation[:value]
            answer.send(:add_error, question, :answer_group_maximum,
                        validation[:message] || "Needs at most #{validation[:value]} question(s) answered.")
          end
        end

        def validate_answer_group_require_all_or_none(question, validation, value)
          group = answer.question_groups[validation[:group]]
          answered = answer.send(:calc_answered, group)
          if answered > 0 && answered < group.count
            answer.send(:add_error, question, :answer_group_require_all_or_none,
                        validation[:message] || "Needs all or none of these questions answered.")
          end
        end

        def depends_on_key_answered(key)
          answer.depends_on_lookup[key]
        end

        private

        def convert_answer_value(question, value)
          case question.type
          when :float
            Float(value)
          when :integer
            Integer(value)
          when :date
            DateTime.strptime(value, "%d-%m-%Y")
          else
            value
          end
        rescue ArgumentError => e
          raise InvalidValue, e.message
        rescue TypeError => e
          fail InvalidValue, e.message
        end
      end
    end
  end
end

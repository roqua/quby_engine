module Quby
  class AnswerValidator
    attr_reader :questionnaire
    attr_reader :answer

    def initialize(questionnaire, answer)
      @questionnaire = questionnaire
      @answer        = answer
    end

    def validate
      return if answer.aborted

      questionnaire.questions.each do |question|
        next unless question
        next if question.hidden?

        if question.depends_on.present?
          next unless question.depends_on.any? { |key| answer.send(key) }
        end

        value = answer.send(question.key)
        next if answer.skip_validation?(value, question)

        question.validations.each do |validation|
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
          when :answer_group_minimum
            validate_answer_group_minimum(question, validation, value)
          when :answer_group_maximum
            validate_answer_group_maximum(question, validation, value)
          end
        end
      end
    end

    def validate_required(question, validation, value)
      if question.type == :check_box && value.values.reduce(:+) == 0
        answer.send(:add_error, question, validation[:type], validation[:message] || "Must be answered.")
      elsif value.blank?
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
      if not match or match[0] != value
        answer.send(:add_error, question, validation[:type], validation[:message] || "Does not match pattern expected.")
      end
    end

    def validate_minimum(question, validation, value)
      if not value.blank? and value.to_f < validation[:value]
        answer.send(:add_error, question, validation[:type], validation[:message] || "Smaller than minimum")
      end
    end

    def validate_maximum(question, validation, value)
      if not value.blank? and value.to_f > validation[:value]
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
  end
end
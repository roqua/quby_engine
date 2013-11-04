module Quby
  class AnswerValidator
    attr_reader :questionnaire
    attr_reader :answer_record

    def initialize(questionnaire, answer_record)
      @questionnaire = questionnaire
      @answer_record = answer_record
    end

    def validate
      return if answer_record.aborted

      questionnaire.questions.each do |question|
        next unless question
        next if question.hidden?

        if question.depends_on.present?
          next unless question.depends_on.any? { |key| answer_record.send(key) }
        end

        value = answer_record.send(question.key)
        next if answer_record.clear_and_skip?(value, question)

        question.validations.each do |validation|
          case validation[:type]
          when :valid_integer
            next if value.blank?
            begin
              Integer(value)
            rescue ArgumentError
              answer_record.send(:add_error, question, :valid_integer, validation[:message] || "Invalid integer")
            end
          when :valid_float
            next if value.blank?
            begin
              Float(value)
            rescue ArgumentError
              answer_record.send(:add_error, question, :valid_float, validation[:message] || "Invalid float")
            end
          when :regexp
            next if value.blank?
            match = validation[:matcher].match(value)
            if not match or match[0] != value
              answer_record.send(:add_error, question, validation[:type], validation[:message] || "Does not match pattern expected.")
            end
          when :requires_answer
            if question.type == :check_box && value.values.reduce(:+) == 0
              answer_record.send(:add_error, question, validation[:type], validation[:message] || "Must be answered.")
            elsif value.blank?
              answer_record.send(:add_error, question, validation[:type], validation[:message] || "Must be answered.")
            end
          when :minimum
            if not value.blank? and value.to_f < validation[:value]
              answer_record.send(:add_error, question, validation[:type], validation[:message] || "Smaller than minimum")
            end
          when :maximum
            if not value.blank? and value.to_f > validation[:value]
              answer_record.send(:add_error, question, validation[:type], validation[:message] || "Exceeds maximum")
            end
          when :too_many_checked
            if answer_record.send(question.uncheck_all_option) == 1 and value.values.reduce(:+) > 1
              answer_record.send(:add_error, question, :too_many_checked, validation[:message] || "Invalid combination of options.")
            end
          when :not_all_checked
            if answer_record.send(question.check_all_option) == 1 and
               value.values.reduce(:+) < value.length - (question.uncheck_all_option ? 1 : 0)
              answer_record.send(:add_error, question, :not_all_checked, validation[:message] || "Invalid combination of options.")
            end
          when :answer_group_minimum
            answered = answer_record.send(:calc_answered, answer_record.question_groups[validation[:group]])
            if answered < validation[:value]
              answer_record.send(:add_error, question, :answer_group_minimum,
                        validation[:message] || "Needs at least #{validation[:value]} question(s) answered.")
            end
          when :answer_group_maximum
            answered = answer_record.send(:calc_answered, answer_record.question_groups[validation[:group]])
            if answered > validation[:value]
              answer_record.send(:add_error, question, :answer_group_maximum,
                        validation[:message] || "Needs at most #{validation[:value]} question(s) answered.")
            end
          end
        end
      end
    end
  end
end
module Quby
  module AnswerValidations
    def cleanup_input
      questionnaire.questions.each do |question|
        next unless question
        next if question.hidden?

        answer = self.send(question.key)
        clear_question(question) if answer && clear_and_skip?(answer, question)
      end
    end

    def clear_question(question)
      value.delete(question.key.to_s)
      if question.type == :check_box
        question.options.each do |opt|
          value.delete(opt.key.to_s)
        end
      end
    end

    def calculated_attributes
      @calculated_attributes ||= AttributeCalculator.new(questionnaire, self)
    end

    def hidden_questions
      calculated_attributes.hidden
    end

    def shown_questions
      calculated_attributes.shown
    end

    def question_groups
      calculated_attributes.groups
    end

    def parent_option_is_not_selected(question)
      return false unless question.parent and question.parent_option_key

      case question.parent.type
      when :radio
        value[question.parent.key.to_s] != question.parent_option_key.to_s
      when :check_box
        value[question.parent.key.to_s].andand[question.parent_option_key.to_s] != 1
      else
        false
      end
    end

    def clear_and_skip?(answer, question)
      return true if answer == "DESELECTED_RADIO_VALUE"
      return true if answer == question.extra_data[:placeholder].to_s
      return true if parent_option_is_not_selected(question)
      return true if hidden_questions.andand.include?(question.key)
      false
    end

    def validate_answers
      AnswerValidator.new(questionnaire, self).validate
    end

  end
end
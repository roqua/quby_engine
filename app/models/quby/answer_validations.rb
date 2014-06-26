require 'quby/items/question'
require 'quby/answers/services/attribute_calculator'
require 'quby/answers/services/answer_validator'

module Quby
  module AnswerValidations
    def cleanup_input
      questionnaire.questions.each do |question|
        next unless question
        next if question.hidden?

        answer = send(question.key)
        if answer && clear?(answer, question)
          clear_question(question)
        elsif answer && question.type == :textarea
          send("#{question.key}=", answer.gsub("\r\n", "\n"))
        end
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
      @calculated_attributes ||= Answers::Services::AttributeCalculator.new(questionnaire, self)
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

    def clear?(answer, question)
      return true if question.is_a?(Questions::SelectQuestion)  && answer == question.extra_data[:placeholder].to_s
      return true if question.is_a?(Questions::StringQuestion)  && answer == ""
      return true if question.is_a?(Questions::TextQuestion)    && answer == ""
      return true if question.is_a?(Questions::IntegerQuestion) && answer == ""
      return true if question.is_a?(Questions::FloatQuestion)   && answer == ""
      return true if parent_option_is_not_selected(question)
      return true if hidden_questions.andand.include?(question.key)
      false
    end

    def skip_validation?(answer, question)
      return true if parent_option_is_not_selected(question)
      return true if hidden_questions.andand.include?(question.key)
      false
    end

    def validate_answers
      Answers::Services::AnswerValidator.new(questionnaire, self).validate
    end
  end
end

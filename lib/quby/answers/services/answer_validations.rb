# frozen_string_literal: true

require 'quby/questionnaires/entities'
require 'quby/answers/services/attribute_calculator'
require 'quby/answers/services/answer_validator'

module Quby
  module Answers
    module Services
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
          question.answer_keys.each do |key|
            value[key.to_s] = nil
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

        def depends_on_lookup
          calculated_attributes.depends_on_lookup
        end

        def parent_option_is_not_selected(question)
          return false unless question.parent and question.parent_option_key

          case question.parent.type
          when :radio
            value[question.parent.key.to_s] != question.parent_option_key.to_s
          when :check_box
            value[question.parent.key.to_s]&.fetch(question.parent_option_key.to_s, nil) != 1
          else
            false
          end
        end

        def clear?(answer, question)
          # rubocop:disable LineLength
          return true if question.is_a?(Questionnaires::Entities::Questions::SelectQuestion)  && answer == question.extra_data[:placeholder].to_s
          return true if question.is_a?(Questionnaires::Entities::Questions::StringQuestion)  && answer == ""
          return true if question.is_a?(Questionnaires::Entities::Questions::TextQuestion)    && answer == ""
          return true if question.is_a?(Questionnaires::Entities::Questions::IntegerQuestion) && answer == ""
          return true if question.is_a?(Questionnaires::Entities::Questions::FloatQuestion)   && answer == ""
          return true if parent_option_is_not_selected(question)
          return true if hidden_questions&.include?(question.key)
          false
        end

        def skip_validation?(answer, question)
          return true if parent_option_is_not_selected(question)
          return true if hidden_questions&.include?(question.key)
          false
        end

        def validate_answers
          AnswerValidator.new(questionnaire, self).validate
        end
      end
    end
  end
end

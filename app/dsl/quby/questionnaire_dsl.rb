require 'quby/questionnaire_dsl/questionnaire_builder'
require 'quby/questionnaire_dsl/panel_builder'
require 'quby/questionnaire_dsl/table_builder'
require 'quby/questionnaire_dsl/question_builder'
require 'quby/questionnaire_dsl/score_builder'

module Quby
  module QuestionnaireDsl
    def self.enhance(target_instance, definition)
      q = QuestionnaireBuilder.new(target_instance)
      q.instance_eval(definition)
      
      target_instance.questions.compact.each do |question|
        
        question.options.each do |option|
          if option.hides_questions.present?
            option.hides_questions.each do |key|
              raise "Question #{question.key} option #{option.key} hides nonexistent question #{key}" unless target_instance.question_hash[key]
            end
          end
        end
      end
    end
  end
end

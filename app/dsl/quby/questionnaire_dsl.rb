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
    end
  end
end

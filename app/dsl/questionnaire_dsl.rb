require 'questionnaire_builder'
require 'panel_builder'
require 'table_builder'
require 'question_builder'
require 'score_builder'

module Quby
  module QuestionnaireDsl
    def self.enhance(target_instance, definition)
      q = QuestionnaireBuilder.new(target_instance)
      q.instance_eval(definition)
    end
  end
end

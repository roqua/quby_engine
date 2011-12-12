require 'quby/questionnaire_builder'
require 'quby/panel_builder'
require 'quby/table_builder'
require 'quby/question_builder'
require 'quby/score_builder'

module Quby
  module QuestionnaireDsl
    def self.enhance(target_instance, definition)
      q = QuestionnaireBuilder.new(target_instance)
      q.instance_eval(definition)
    end
  end
end

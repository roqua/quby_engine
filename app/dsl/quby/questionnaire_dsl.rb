require 'quby/questionnaire_dsl/questionnaire_builder'
module Quby
  module QuestionnaireDsl
    def self.build(key, definition = nil, &block)
      Questionnaire.new(key).tap do |questionnaire|
        builder = QuestionnaireBuilder.new(questionnaire)
        builder.instance_eval(definition) if definition
        builder.instance_eval(block) if block
      end
    end

    def self.enhance(target_instance, definition)
      q = QuestionnaireBuilder.new(target_instance)
      q.instance_eval(definition)
    end
  end
end

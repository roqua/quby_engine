# frozen_string_literal: true

require 'quby/questionnaires/dsl/base'
require 'quby/questionnaires/dsl/helpers'
require 'quby/questionnaires/dsl/questionnaire_builder'

module Quby
  module Questionnaires
    module DSL
      def self.build_from_definition(definition)
        Entities::Questionnaire.new(definition.key, last_update: definition.timestamp).tap do |questionnaire|
          builder = QuestionnaireBuilder.new(questionnaire)
          builder.instance_eval(definition.sourcecode, definition.key) if definition.sourcecode
          questionnaire.callback_after_dsl_enhance_on_questions
          questionnaire.validate_questions
        end
      end

      def self.build(key, sourcecode = nil, timestamp: nil, &block)
        Entities::Questionnaire.new(key, last_update: timestamp).tap do |questionnaire|
          builder = QuestionnaireBuilder.new(questionnaire)
          builder.instance_eval(sourcecode, key) if sourcecode
          builder.instance_eval(&block) if block
          questionnaire.callback_after_dsl_enhance_on_questions
          questionnaire.validate_questions
        end
      end
    end
  end
end

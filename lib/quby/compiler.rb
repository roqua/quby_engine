# frozen_string_literal: true

require 'quby/compiler/entities'
require 'quby/compiler/dsl'
require 'quby/compiler/outputs'

module Quby
  module Compiler
    def self.compile(key, sourcecode, path: nil, &block)
      if block # defined in block for tests
        questionnaire = DSL.build(key, path: path, &block)
      else # sourcecode given as string
        tempfile = Tempfile.new(key)
        questionnaire = Entities::Questionnaire.new(key)
        uuid = SecureRandom.uuid
        Thread.current['quby-questionnaire-loading'] = Quby::Compiler::DSL::QuestionnaireBuilder.new(questionnaire)

        tempfile.puts "Thread.current['quby-questionnaire-loading'].instance_eval do"
        tempfile.puts sourcecode
        tempfile.puts "end"
        tempfile.flush
        Thread.current[uuid] = nil

        load tempfile.path

        questionnaire.callback_after_dsl_enhance_on_questions
        questionnaire
      end

      {
        outputs: {
          quby_frontend_v1: Outputs::QubyFrontendV1Serializer.new(questionnaire).as_json
        }
      }.deep_stringify_keys
    ensure
      # We can only close and remove the file once serializers have finished.
      # The serializers need the file in order to grab the source for score blocks
      tempfile&.close
      tempfile&.unlink
    end
  end
end
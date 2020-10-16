# frozen_string_literal: true

require 'quby/compiler/entities'
require 'quby/compiler/dsl'
require 'quby/compiler/outputs'

module Quby
  module Compiler
    def self.compile(key, sourcecode, &block)
      entity = DSL.build(key, sourcecode, &block)

      {
        outputs: {
          quby_frontend_v1: Outputs::QubyFrontendV1Serializer.new(entity).as_json
        }
      }.deep_stringify_keys
    end
  end
end
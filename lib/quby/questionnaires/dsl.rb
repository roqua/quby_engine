# frozen_string_literal: true

module Quby
  module Questionnaires
    module DSL
      def self.build_from_definition(definition)
        compiled = Quby::Compiler.compile(definition.key, definition.sourcecode, path: definition.path)
        data = JSON.parse(compiled["outputs"]["quby_frontend_v1"].to_json)
        Deserializer.from_json(data)
      end

      def self.build(key, sourcecode = nil, timestamp: nil, &block)
        compiled = Quby::Compiler.compile(key, sourcecode, &block)
        data = JSON.parse(compiled["outputs"]["quby_frontend_v1"].to_json)
        Deserializer.from_json(data)
      end
    end
  end
end

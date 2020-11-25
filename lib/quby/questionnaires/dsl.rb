# frozen_string_literal: true

module Quby
  module Questionnaires
    module DSL
      # Deprecated, precompile elsewhere and use from_json
      def self.build_from_definition(definition)
        compiled = Quby::Compiler.compile(definition.key, definition.sourcecode, seeds: [], lookup_tables: {}, path: definition.path, last_update: definition.timestamp)
        data = JSON.parse(compiled[:outputs][:quby_frontend_v1].content)
        Deserializer.from_json(data)
      end

      # Deprecated, precompile elsewhere and use from_json
      def self.build(key, sourcecode = nil, timestamp: nil, &block)
        compiled = Quby::Compiler.compile(key, sourcecode, seeds: [], lookup_tables: {}, last_update: timestamp, &block)
        data = JSON.parse(compiled[:outputs][:quby_frontend_v1].content)
        Deserializer.from_json(data)
      end

      def self.from_json(hash)
        Deserializer.from_json(hash)
      end
    end
  end
end

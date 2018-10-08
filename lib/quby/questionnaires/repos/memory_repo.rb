# frozen_string_literal: true

require 'quby/questionnaires/repos'
require 'quby/questionnaires'

module Quby
  module Questionnaires
    module Repos
      class MemoryRepo < Base
        attr_reader :records

        def initialize(definitions = {})
          @records = definitions.map do |key, definition|
            [key, record_for_definition(definition)]
          end.to_h
        end

        def keys
          records.keys
        end

        def find(key)
          fail(QuestionnaireNotFound, key) unless exists?(key)
          record = records.fetch(key)
          entity(key, record.fetch(:definition), record.fetch(:last_update))
        end

        def exists?(key)
          records.key?(key)
        end

        def timestamp(key)
          fail(QuestionnaireNotFound, key) unless exists?(key)
          records.fetch(key).fetch(:last_update)
        end

        private

        def store!(key, definition)
          records[key] = record_for_definition(definition)
        end

        def record_for_definition(definition)
          {definition: definition, last_update: Time.now}
        end
      end
    end
  end
end

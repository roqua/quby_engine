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

        def all
          records.keys.map do |key|
            find(key)
          end
        end

        def find(key)
          fail(QuestionnaireNotFound, key) unless exists?(key)
          record = records.fetch(key)
          entity(key, record.fetch(:definition), record[:last_update])
        end

        def exists?(key)
          records.key?(key)
        end

        def create!(key, definition)
          fail(DuplicateQuestionnaire, key) if exists?(key)
          records[key] = record_for_definition(definition)
          find(key)
        end

       private

        def record_for_definition(definition)
          {definition: definition, last_update: Time.now}
        end
      end
    end
  end
end

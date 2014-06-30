require 'quby/questionnaires/repos'
require 'quby/questionnaires'

module Quby
  module Questionnaires
    module Repos
      class MemoryRepo < Base
        attr_reader :definitions

        def initialize(definitions = {})
          @definitions = definitions
        end

        def all
          definitions.keys.map do |key|
            find(key)
          end
        end

        def find(key)
          fail(QuestionnaireNotFound, key) unless exists?(key)
          entity(key, definitions.fetch(key), Time.now)
        end

        def exists?(key)
          definitions.has_key?(key)
        end
      end
    end
  end
end

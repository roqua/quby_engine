module Quby
  module Questionnaires
    module Repos
      class Base
        def all
          keys.map { |key| find(key) }
        end

        def find(key)
          fail NotImplementedError
        end

        def exists?(key)
          fail NotImplementedError
        end

        def timestamp(key)
          fail NotImplementedError
        end

        def create!(key, definition)
          fail(DuplicateQuestionnaire, key) if exists?(key)
          store!(key, definition)
          find(key)
        end

        def update!(key, definition)
          fail(QuestionnaireNotFound, key) unless exists?(key)
          store!(key, definition)
          find(key)
        end

        private

        def store!(key, definition)
          fail NotImplementedError
        end

        def entity(key, definition, timestamp)
          DSL.build(key, definition, timestamp: timestamp)
        end
      end
    end
  end
end

require 'quby/questionnaires/entities/definition'

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

        def create!(key, sourcecode)
          fail(DuplicateQuestionnaire, key) if exists?(key)
          store!(key, sourcecode)
          find(key)
        end

        def update!(key, sourcecode)
          fail(QuestionnaireNotFound, key) unless exists?(key)
          store!(key, sourcecode)
          find(key)
        end

        private

        def store!(key, sourcecode)
          fail NotImplementedError
        end

        def entity(key, sourcecode, timestamp)
          Entities::Definition.new(key: key, sourcecode: sourcecode, timestamp: timestamp)
        end
      end
    end
  end
end

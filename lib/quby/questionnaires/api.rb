module Quby
  module Questionnaires
    class API
      def initialize(questionnaire_repo:)
        @repo = questionnaire_repo
      end

      def find(key)
        definition = @repo.find key
        DSL.build_from_definition(definition)
      end

      def exists?(questionnaire_key)
        @repo.exists? questionnaire_key
      end

      def all
        @repo.keys.map { |key| find(key) }
      end

      def validate(key, sourcecode)
        definition = Entities::Definition.new(key: key, sourcecode: sourcecode)
        definition.valid?
        definition
      end
    end
  end
end

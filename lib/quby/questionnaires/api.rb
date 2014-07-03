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
        questionnaire = Entities::Questionnaire.new(key)
        validator     = Services::DefinitionValidator.new(questionnaire, sourcecode)
        validator.validate
        questionnaire
      end
    end
  end
end

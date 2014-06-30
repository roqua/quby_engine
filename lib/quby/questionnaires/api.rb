module Quby
  module Questionnaires
    class API
      def initialize(questionnaire_repo:)
        @repo = questionnaire_repo
      end

      def find(key)
        @repo.find key
      end

      def exists?(questionnaire_key)
        @repo.exists? questionnaire_key
      end

      def all
        @repo.all
      end
    end
  end
end

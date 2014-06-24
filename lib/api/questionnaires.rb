module Quby
  class Questionnaires
    def initialize(questionnaire_repo:)
      @repo = questionnaire_repo
    end

    def find(key)
      @repo.find key
    end
  end
end

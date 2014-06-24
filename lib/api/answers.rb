module Quby
  class Answers
    def initialize(answer_repo:)
      @repo = answer_repo
    end

    def find(questionnaire_key, answer_id)
      @repo.find questionnaire_key, answer_id
    end

    def reload(answer)
      @repo.reload answer
    end

    def all(questionnaire_key)
      @repo.all questionnaire_key
    end

    def create!(questionnaire_key, attributes = {})
      @repo.create! questionnaire_key, attributes
    end

    def update!(answer)
      @repo.update! answer
    end

    def generate_outcome(answer)
      Quby::OutcomeCalculation.new(answer).calculate
    end

    def regenerate_outcome!(answer)
      Quby::OutcomeCalculation.new(answer).update_scores
    end
  end
end

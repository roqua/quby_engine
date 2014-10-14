module Quby
  module Answers
    class API
      def initialize(answer_repo:)
        @repo = answer_repo
      end

      def find(questionnaire_key, answer_id)
        @repo.find questionnaire_key, answer_id
      end

      def find_completed_after(time, answer_ids)
        @repo.find_completed_after time, answer_ids
      end

      def reload(answer)
        @repo.reload answer
      end

      def all(questionnaire_key)
        @repo.all questionnaire_key
      end

      def create!(questionnaire_key, attributes = {})
        questionnaire = Quby.questionnaires.find(questionnaire_key)
        answer = Services::BuildAnswer.new(questionnaire, attributes).build
        @repo.create! answer
      end

      def update!(answer)
        @repo.update! answer
      end

      def generate_outcome(answer)
        Services::OutcomeCalculation.new(answer).calculate
      end

      def regenerate_outcome!(answer)
        Services::OutcomeCalculation.new(answer).update_scores
      end
    end
  end
end

require 'active_support/concern'

module Quby
  module ScoreCalculations
    extend ActiveSupport::Concern

    included do
      before_save do
        self.scores = calculate_scores
      end
    end

    def calculate_scores
      scores = {}

      questionnaire.scores.each do |score|
        begin
          scores[score.key] = ScoreCalculator.calculate(self.value_by_regular_values,
                                                        self.patient.andand.slice(:birthyear, :gender),
                                                        &score.scorer)
        rescue StandardError => e
          scores[score.key] = {:error => e.message,
                               :backtrace => e.backtrace}
        end
      end

      scores
    end
  end
end
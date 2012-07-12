require 'active_support/concern'

module Quby
  module ScoreCalculations
    extend ActiveSupport::Concern

    included do
      before_save :set_scores

      def set_scores
        self.scores = calculate_scores
      end
    end

    def calculate_scores
      scores = {}

      questionnaire.scores.each do |score|
        begin
          scores[score.key] = ScoreCalculator.calculate(self.value_by_regular_values,
                                                        self.patient.andand.slice("birthyear", "gender"),
                                                        &score.scorer)
        rescue StandardError => e
          scores[score.key] = {:exception => e.message,
                               :backtrace => e.backtrace}
        end
      end

      scores
    end

    def update_scores
      self.class.skip_callback :save, :before, :set_scores
      update_attribute(:scores, calculate_scores)
      self.class.set_callback :save, :before, :set_scores
    end
  end
end

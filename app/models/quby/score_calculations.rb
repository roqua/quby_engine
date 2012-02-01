module Quby
  module ScoreCalculations
    extend ActiveSupport::Concern

    included do
      before_save do
        self.scores = calculate_scores
      end
    end

    module InstanceMethods
      def calculate_scores
        scores = {}

        questionnaire.scores.each do |score|
          begin
            scores[score.key] = ScoreCalculator.calculate({:values => self.value_by_values}, &score.scorer)
          rescue StandardError => e
            scores[score.key] = {:error => e.message}
          end
        end
        
        scores
      end
    end
  end
end
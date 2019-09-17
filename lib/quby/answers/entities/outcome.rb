# frozen_string_literal: true

module Quby
  module Answers
    module Entities
      class Outcome
        # @return [Hash]
        attr_accessor :scores

        # @return [Hash]
        attr_accessor :actions

        # @return [Hash]
        attr_accessor :completion

        # @return [Time]
        attr_accessor :generated_at

        def initialize(scores: {}, actions: {}, completion: {}, generated_at: nil)
          self.scores = scores
          self.actions = actions
          self.completion = completion
          self.generated_at = generated_at
        end

        def scores
          @scores.with_indifferent_access
        end

        def actions
          @actions.with_indifferent_access
        end

        def action
          alarm_scores      = scores.select { |key, value| value["status"].to_s == "alarm" }
          alarm_answers     = actions[:alarm] || []
          attention_scores  = scores.select { |key, value| value["status"].to_s == "attention" }
          attention_answers = actions[:attention] || []

          return :alarm     if alarm_scores.any?     || alarm_answers.any?
          return :attention if attention_scores.any? || attention_answers.any?
          nil
        end
      end
    end
  end
end

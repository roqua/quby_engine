require 'virtus'

module Quby
  module Answers
    module Entities
      class Outcome
        include Virtus.model

        attribute :scores,               Hash,    default: {}
        attribute :actions,              Hash,    default: {}
        attribute :completion,           Hash,    default: {}
        attribute :generated_at,         Time

        def scores
          super.with_indifferent_access
        end

        def actions
          super.with_indifferent_access
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

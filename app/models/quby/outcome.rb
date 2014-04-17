module Quby
  class Outcome
    include Virtus

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

      return :alarm     if alarm_scores.any?     or alarm_answers.any?
      return :attention if attention_scores.any? or attention_answers.any?
      nil
    end
  end
end

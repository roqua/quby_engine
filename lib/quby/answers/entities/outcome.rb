# frozen_string_literal: true

require 'active_model'
require 'active_model_attributes'

module Quby
  module Answers
    module Entities
      class Outcome
        include ActiveModel::Model
        include ActiveModelAttributes

        attribute :scores,               :hash,    default: {}
        attribute :actions,              :hash,    default: {}
        attribute :completion,           :hash,    default: {}
        attribute :generated_at,         :time

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

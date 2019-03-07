# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module Quby
  module Answers
    module Entities
      class Outcome < Dry::Struct
        module Types
          include Dry::Types.module
        end

        attribute :scores,               Types::Hash.default({})
        attribute :actions,              Types::Hash.default({})
        attribute :completion,           Types::Hash.default({})
        attribute :generated_at,         Types::Time.meta(omittable: true)

        def scores
          self[:scores].with_indifferent_access
        end

        def actions
          self[:actions].with_indifferent_access
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

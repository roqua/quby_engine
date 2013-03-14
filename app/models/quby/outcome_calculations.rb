require 'active_support/concern'

module Quby
  module OutcomeCalculations
    extend ActiveSupport::Concern

    included do
      before_save :calculate_builders
    end

    def action
      alarm_scores      = scores.select {|key, value| value["status"].to_s == "alarm" }
      alarm_answers     = actions[:alarm] || []
      attention_scores  = scores.select {|key, value| value["status"].to_s == "attention" }
      attention_answers = actions[:attention] || []

      return :alarm     if alarm_scores.any?     or alarm_answers.any?
      return :attention if attention_scores.any? or attention_answers.any?
      nil
    end

    def calculate_builders
      results = {}
      score_results = {}
      action_results = {}
      completion_result = {}

      questionnaire.score_builders.each do |key, builder|
        begin
          result = ScoreCalculator.calculate(self.value_by_regular_values,
                                             self.completed_at,
                                             self.patient.andand.slice("birthyear", "gender"),
                                             results,
                                             &builder.calculation)
          result.reverse_merge!(builder.options) if builder.score
          result = {"value" => result} if builder.completion
          results[key] = result
        rescue StandardError => e
          results[key] = {:exception => e.message,
                          :backtrace => e.backtrace}.reverse_merge(builder.options)
        end

        score_results[key] = results[key] if builder.score
        action_results[key] = results[key] if builder.action
        completion_result = results[key] if builder.completion
      end

      self.scores = score_results
      self.actions = action_results
      self.completion = completion_result

      results
    end

    # Calculate scores and actions, write to the database but bypass any validations
    # This function is called by parts of the system that only want to calculate
    # stuff, and can't help it if an answer is not completed.
    def update_scores
      self.class.skip_callback :save, :before, :calculate_builders
      # MongoDB won't save new hash order if we don't clear it first.
      update_attribute(:scores, {})
      update_attribute(:actions, {})
      update_attribute(:completion, {})

      # Now we can fill it back up
      calculate_builders
      update_attribute(:scores, scores)
      update_attribute(:actions, actions)
      update_attribute(:completion, completion)
      self.class.set_callback :save, :before, :calculate_builders
    end
  end
end
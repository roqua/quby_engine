require 'active_support/concern'

module Quby
  module OutcomeCalculations
    extend ActiveSupport::Concern

    included do
      before_save :set_scores
      before_save :set_actions
      before_save :set_completion

      def set_scores
        self.scores = calculate_scores
      end

      def set_actions
        self.actions = calculate_actions
      end

      def set_completion
        self.completion = calculate_completion
      end
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

    def calculate_scores
      scores = {}

      questionnaire.scores.each do |score|
        begin
          result = ScoreCalculator.calculate(self.value_by_regular_values,
                                             self.patient.andand.slice("birthyear", "gender"),
                                             scores,
                                             &score.calculation)
          scores[score.key] = result.reverse_merge(score.options)
        rescue StandardError => e
          scores[score.key] = {:exception => e.message,
                               :backtrace => e.backtrace}.reverse_merge(score.options)
        end
      end

      scores
    end

    def calculate_actions
      actions = {}

      questionnaire.actions.each do |action|
        begin
          actions[action.key] = ScoreCalculator.calculate(self.value_by_regular_values,
                                                          self.patient.andand.slice("birthyear", "gender"),
                                                          &action.calculation)
        rescue StandardError => e
          actions[action.key] = {:exception => e.message,
                                 :backtrace => e.backtrace}
        end
      end

      actions
    end

    def calculate_completion
      if questionnaire.completion
        {
          value: ScoreCalculator.calculate(self.value_by_regular_values,
                                          self.patient.andand.slice("birthyear", "gender"),
                                          scores,
                                          &questionnaire.completion.calculation)
        }.stringify_keys
      else
        {}
      end
    rescue StandardError => e
      {:exception => e.message,
       :backtrace => e.backtrace}
    end

    # Calculate scores and actions, write to the database but bypass any validations
    # This function is called by parts of the system that only want to calculate
    # stuff, and can't help it if an answer is not completed.
    def update_scores
      self.class.skip_callback :save, :before, :set_scores
      self.class.skip_callback :save, :before, :set_actions
      self.class.skip_callback :save, :before, :set_completion
      update_attribute(:scores,     calculate_scores)
      update_attribute(:actions,    calculate_actions)
      update_attribute(:completion, calculate_completion)
      self.class.set_callback :save, :before, :set_scores
      self.class.set_callback :save, :before, :set_actions
      self.class.set_callback :save, :before, :set_completion
    end
  end
end
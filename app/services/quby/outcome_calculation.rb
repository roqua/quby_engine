require 'active_support/concern'

module Quby
  class OutcomeCalculation
    attr_reader :answer

    def initialize(answer)
      @answer = answer
    end

    def calculate
      results = {}
      score_results = {}
      action_results = {}
      completion_result = {}

      questionnaire.score_calculations.each do |key, calculation|
        begin
          result = ScoreCalculator.calculate(value_by_regular_values,
                                             completed_at,
                                             patient.andand.slice("birthyear", "gender"),
                                             results,
                                             &calculation.calculation)
          result.reverse_merge!(calculation.options) if calculation.score
          result = {"value" => result} if calculation.completion
          results[key] = result
        rescue StandardError => e
          results[key] = {exception: e.message,
                          backtrace: e.backtrace}.reverse_merge(calculation.options)
        end

        score_results[key] = results[key] if calculation.score
        action_results[key] = results[key] if calculation.action
        completion_result = results[key] if calculation.completion
      end

      Outcome.new(scores: score_results,
                  actions: action_results,
                  completion: completion_result,
                  generated_at: Time.now)
    end

    # Calculate scores and actions, write to the database but bypass any validations
    # This function is called by parts of the system that only want to calculate
    # stuff, and can't help it if an answer is not completed.
    def update_scores
      # Now we can fill it back up
      outcome = calculate
      answer.outcome = outcome
      Quby.answers.update!(answer)
    end

    private

    def questionnaire
      answer.questionnaire
    end

    def value_by_regular_values
      answer.value_by_regular_values
    end

    def completed_at
      answer.completed_at
    end

    def patient
      answer.patient
    end
  end
end

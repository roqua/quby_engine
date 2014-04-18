require 'active_support/concern'

module Quby
  class OutcomeCalculations
    attr_reader :answer

    def initialize(answer)
      @answer = answer
    end

    def calculate_builders
      results = {}
      score_results = {}
      action_results = {}
      completion_result = {}

      questionnaire.score_calculations.each do |key, builder|
        begin
          result = ScoreCalculator.calculate(value_by_regular_values,
                                             completed_at,
                                             patient.andand.slice("birthyear", "gender"),
                                             results,
                                             &builder.calculation)
          result.reverse_merge!(builder.options) if builder.score
          result = {"value" => result} if builder.completion
          results[key] = result
        rescue StandardError => e
          results[key] = {exception: e.message,
                          backtrace: e.backtrace}.reverse_merge(builder.options)
        end

        score_results[key] = results[key] if builder.score
        action_results[key] = results[key] if builder.action
        completion_result = results[key] if builder.completion
      end

      outcome = Outcome.new(scores: score_results,
                            actions: action_results,
                            completion: completion_result,
                            generated_at: Time.now)
      answer.outcome = outcome
      outcome
    end

    # Calculate scores and actions, write to the database but bypass any validations
    # This function is called by parts of the system that only want to calculate
    # stuff, and can't help it if an answer is not completed.
    def update_scores
      # Now we can fill it back up
      calculate_builders
      Quby.answer_repo.update!(answer)
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

require 'quby/answers/services/filters_answer_value'
require 'quby/answers/services/outcome_calculation'

module Quby
  module Answers
    module Services
      class UpdatesAnswers
        attr_reader :answer

        def initialize(answer)
          @answer = answer
        end

        def update(new_attributes = {})
          answer.raw_params = new_attributes

          attribute_filter   = FiltersAnswerValue.new(answer.questionnaire)
          attribute_filter.filter(new_attributes).each do |name, value|
            answer.send("#{name}=", value)
          end

          answer.extend AnswerValidations
          answer.cleanup_input
          answer.validate_answers

          if answer.errors.empty?
            if new_attributes["rendered_at"]
              started_completing_at = Time.at(new_attributes["rendered_at"].to_i)
            else
              started_completing_at = nil
            end

            answer.mark_completed(started_completing_at)
            answer.outcome = OutcomeCalculation.new(answer).calculate
            Quby.answers.update!(answer)
            succeed!
          else
            fail!
          end
        end

        def on_success(&block)
          @success_callback = block
        end

        def on_failure(&block)
          @failure_callback = block
        end

        protected

        def succeed!
          @success_callback.call if @success_callback
        end

        def fail!
          @failure_callback.call if @failure_callback
        end
      end
    end
  end
end

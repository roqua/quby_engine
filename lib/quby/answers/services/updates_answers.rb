# frozen_string_literal: true

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
          save_raw_params_on_error(new_attributes) do
            attribute_filter = FiltersAnswerValue.new(answer.questionnaire)
            attribute_filter.filter(new_attributes).each { |name, value| answer.send("#{name}=", value) }

            answer.extend AnswerValidations
            answer.cleanup_input
            answer.validate_answers

            if answer.errors.empty?
              if new_attributes["rendered_at"].present?
                started_at = Time.at(new_attributes["rendered_at"].to_i)
              else
                started_at = nil
              end
              answer.mark_completed(start_time: started_at)
              answer.outcome = OutcomeCalculation.new(answer).calculate
              Quby.answers.update!(answer)
              succeed!
            else
              if Rails.env.test?
                raise NoServerSideValidationInTestError, "There should be no server side validation failures in test"
              end
              if defined? ::Roqua::Support
                ::Roqua::Support::Errors.report(Quby::ValidationError.new(answer.errors.full_messages))
              end
              fail!
            end
          end
        end

        def on_success(&block)
          @success_callback = block
        end

        def on_failure(&block)
          @failure_callback = block
        end

        protected

        def save_raw_params_on_error(new_attributes)
          if new_attributes.respond_to?(:to_unsafe_h)
            answer.raw_params = new_attributes.to_unsafe_h
          else
            answer.raw_params = new_attributes
          end

          backup_answer = answer.clone

          yield

        rescue
          # we dont save answer since it probably has a weird state now, instead we save the a clone of answer
          # that just has the raw_params set on it, so we can do data recovery with the raw_params
          backup_answer.raw_params['could_not_update_at'] = DateTime.now.to_i # to note this is was a failed update
          Quby.answers.update!(backup_answer)
          raise
        end

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

module Quby
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
        answer.set_completed_at
        answer.outcome = OutcomeCalculation.new(answer).calculate
        Quby.answer_repo.update!(answer)
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

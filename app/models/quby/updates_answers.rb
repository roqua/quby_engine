module Quby
  class UpdatesAnswers
    def initialize(answer)
      @answer = answer
    end

    def update(new_attributes = {})
      @answer.attributes = new_attributes

      @answer.extend AnswerValidations
      @answer.cleanup_input
      @answer.validate_answers

      if @answer.errors.empty? and @answer.save
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
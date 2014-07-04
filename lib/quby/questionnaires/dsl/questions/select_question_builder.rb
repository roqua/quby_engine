module Quby
  module Questionnaires
    module DSL
      module Questions
        class SelectQuestionBuilder < Base
          def option(key, options = {}, &block)
            question_option = Entities::QuestionOption.new(key, @question, options)
            if @questionnaire.key_in_use?(question_option.input_key) || @question.key_in_use?(question_option.input_key)
              fail "#{questionnaire.key}:#{@question.key}:#{question_option.key}: " \
                    "A question or option with input key #{question_option.input_key} is already defined."
            end

            @question.options << question_option
            instance_eval(&block) if block
          end
        end
      end
    end
  end
end

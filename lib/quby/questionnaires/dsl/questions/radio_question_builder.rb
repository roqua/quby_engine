module Quby
  module Questionnaires
    module DSL
      module Questions
        class RadioQuestionBuilder < Base
          def inner_title(value)
            question_option = Entities::QuestionOption.new(nil, @question, inner_title: true, description: value)
            @question.options << question_option
          end

          def option(key, options = {}, &block)
            question_option = Entities::QuestionOption.new(key, @question, options)
            if @questionnaire.key_in_use?(question_option.input_key) || @question.key_in_use?(question_option.input_key)
              fail "#{questionnaire.key}:#{@question.key}:#{question_option.key}: " \
                    "A question or option with input key #{question_option.input_key} is already defined."
            end

            @question.options << question_option
            instance_eval(&block) if block
          end

          def title_question(key, options = {}, &block)
            if @questionnaire.key_in_use? key
              fail "#{@questionnaire.key}:#{key}: A question or option with input key #{key} is already defined."
            end

            options = @default_question_options.merge({depends_on: @question.key,
                                                       questionnaire: @questionnaire,
                                                       parent: @question,
                                                       presentation: :next_to_title}.merge(options))

            question = QuestionBuilder.build(key, options, &block)

            @questionnaire.question_hash[key] = question
            @title_question = question
          end

          def question(key, options = {}, &block)
            if @questionnaire.key_in_use? key
              fail "#{@questionnaire.key}:#{key}: A question or option with input key #{key} is already defined."
            end

            options = @default_question_options.merge(options)
                                               .merge(questionnaire: @questionnaire,
                                                      parent: @question,
                                                      parent_option_key: @question.options.last.key)

            question = QuestionBuilder.build(key, options, &block)

            @questionnaire.question_hash[key] = question
            @question.options.last.questions << question
          end

        end
      end
    end
  end
end

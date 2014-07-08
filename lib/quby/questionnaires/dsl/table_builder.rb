require 'quby/questionnaires/entities'

module Quby
  module Questionnaires
    module DSL
      class TableBuilder
        def initialize(panel, options = {})
          @panel = panel
          @table = Entities::Table.new(options)
          @default_question_options = options[:default_question_options] || {}
          @panel.items << @table
        end

        def title(value)
          @table.title = value
        end

        def description(value)
          @table.description = value
        end

        def text(value, options = {})
          @table.items << Entities::Text.new(value.to_s, options)
        end

        def question(key, options = {}, &block)
          if @panel.questionnaire.key_in_use? key
            fail "#{@panel.questionnaire.key}:#{key}: A question or option with input key #{key} is already defined."
          end
          fail "You can't create a slider in a table at the moment" if options[:as] == :slider

          options = @default_question_options.merge(options)
                                             .merge(table: @table,
                                                    questionnaire: @panel.questionnaire)

          question = QuestionBuilder.build(key, options, &block)

          @panel.questionnaire.question_hash[key] = question
          @table.items << question
          @panel.items << question
        end
      end
    end
  end
end

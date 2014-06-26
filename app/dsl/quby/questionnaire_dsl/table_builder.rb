require 'quby/items/table'
require 'quby/items/text'

module Quby
  module QuestionnaireDsl
    class TableBuilder
      def initialize(panel, options = {})
        @panel = panel
        @table = Quby::Items::Table.new(options)
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
        @table.items << Quby::Items::Text.new(value.to_s, options)
      end

      def question(key, options = {}, &block)
        if @panel.questionnaire.key_in_use? key
          fail "#{@panel.questionnaire.key}:#{key}: A question or option with input key #{key} is already defined."
        end
        fail "You can't create a slider in a table at the moment" if options[:as] == :slider

        options = @default_question_options.merge(options)
                                           .merge(table: @table,
                                                  questionnaire: @panel.questionnaire)

        question_builder = QuestionBuilder.new(key, options)
        question_builder.instance_eval(&block) if block
        question = question_builder.build

        @panel.questionnaire.question_hash[key] = question
        @table.items << question
        @panel.items << question
      end
    end
  end
end

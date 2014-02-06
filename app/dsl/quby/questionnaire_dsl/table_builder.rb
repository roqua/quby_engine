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
        t = Quby::Items::Text.new(value.to_s, options)
        @table.items << t
      end

      def question(key, options = {}, &block)
        if @panel.questionnaire.key_in_use? key
          raise "#{@panel.questionnaire.key}:#{key}: A question or option with input key #{key} is already defined."
        end
        raise "You can't create a slider in a table at the moment" if options[:as] == :slider

        q = QuestionBuilder.new(key, @default_question_options.merge(options)
                                                              .merge(table: @table,
                                                                     questionnaire: @panel.questionnaire))
        q.instance_eval(&block) if block
        question = q.build
        @panel.questionnaire.question_hash[key] = question
        @table.items << question
        @panel.items << question
      end
    end
  end
end

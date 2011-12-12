module Quby
  module QuestionnaireDsl
    class TableBuilder
      def initialize(panel, options = {})
        @panel = panel
        @table = Items::Table.new(options) 
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
        t = Items::Text.new(value.to_s, options)
        @table.items << t 
      end

      def question(key, options = {}, &block)
        raise "Question key: #{key} repeated!" if @panel.questionnaire.question_hash[key]

        q = QuestionBuilder.new(key, @default_question_options.merge(options).merge(:table => @table, :questionnaire => @panel.questionnaire))
        @panel.questionnaire.question_hash[key] = q.build
        q.instance_eval(&block) if block

        @table.items << q.build      
        @panel.items << q.build
      end
    end

  end
end

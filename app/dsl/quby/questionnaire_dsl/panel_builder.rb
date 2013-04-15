module Quby
  module QuestionnaireDsl
    class PanelBuilder
      attr_reader :title
      attr_reader :questionnaire

      def initialize(title, options = {})
        @panel = Quby::Items::Panel.new(options.merge({:title => title, :items => []}))
        @default_question_options = options[:default_question_options] || {}
        @questionnaire = options[:questionnaire]
      end

      def build
        @panel
      end

      def title(value)
        @panel.title = value
      end

      def text(value, options = {})
        @panel.items << Quby::Items::Text.new(value.to_s, options)
      end

      def html(value)
        @panel.items << Quby::Items::Text.new('', :html_content => value.to_s)
      end

      def raw_html(value)
        @panel.items << Quby::Items::Text.new('', :raw_content => value.to_s)
      end

      def default_question_options(options = {})
        @default_question_options = @default_question_options.merge(options)
      end

      def question(key, options = {}, &block)
        raise "Question key: #{key} repeated!" if @questionnaire.question_hash[key]

        q = QuestionBuilder.new(key, @default_question_options.merge(options).merge({:questionnaire => @panel.questionnaire}))
        q.instance_eval(&block) if block
        question = q.build
        @questionnaire.question_hash[key] = question
        @panel.items << question
      end

      def table(options = {}, &block)
        t = TableBuilder.new(@panel, options.merge({:questionnaire => @panel.questionnaire, :default_question_options => @default_question_options}))
        t.instance_eval(&block) if block
      end

      protected

      [:radio, :check_box, :scale, :string, :date, :integer, :float, :textarea, :hidden, :select].each do |type|
        define_method type do
          type
        end
      end

    end
  end
end

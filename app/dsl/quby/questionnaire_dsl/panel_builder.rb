module Quby
  module QuestionnaireDsl
    class PanelBuilder
      attr_reader :title
      attr_reader :questionnaire

      def initialize(title, options = {})
        @panel = Items::Panel.new(options.merge({:title => title, :items => []}))
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
        @panel.items << Items::Text.new(value.to_s, options)
      end

      def html(value)
        @panel.items << Items::Text.new('', :html_content => value.to_s)
      end

      def raw_html(value)
        @panel.items << Items::Text.new('', :raw_content => value.to_s)
      end

      def default_question_options(options = {})
        @default_question_options = @default_question_options.merge(options)
      end

      def question(key, options = {}, &block)
        raise "Question key: #{key} repeated!" if @questionnaire.question_hash[key]

        q = QuestionBuilder.new(key, @default_question_options.merge(options).merge({:questionnaire => @panel.questionnaire}))
        @questionnaire.question_hash[key] = q.build
        q.instance_eval(&block) if block

        @panel.items << q.build
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

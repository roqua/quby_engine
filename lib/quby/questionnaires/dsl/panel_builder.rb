require 'quby/questionnaires/entities'

module Quby
  module DSL
    class PanelBuilder
      attr_reader :title
      attr_reader :questionnaire

      def initialize(title, options = {})
        @panel = Quby::Questionnaires::Entities::Items::Panel.new(options.merge(title: title, items: []))
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
        @panel.items << Quby::Questionnaires::Entities::Items::Text.new(value.to_s, options)
      end

      def html(value)
        @panel.items << Quby::Questionnaires::Entities::Items::Text.new('', html_content: value.to_s)
      end

      def raw_html(value)
        @panel.items << Quby::Questionnaires::Entities::Items::Text.new('', raw_content: value.to_s)
      end

      def default_question_options(options = {})
        @default_question_options = @default_question_options.merge(options)
      end

      def question(key, options = {}, &block)
        if @panel.questionnaire.key_in_use? key
          fail "#{@panel.questionnaire.key}:#{key}: A question or option with input key #{key} is already defined."
        end

        options = @default_question_options.merge(options).merge(questionnaire: @panel.questionnaire)
        question_builder = QuestionBuilder.new(key, options)
        question_builder.instance_eval(&block) if block

        question = question_builder.build

        @questionnaire.question_hash[key] = question
        @panel.items << question
      end

      def table(options = {}, &block)
        table_builder = TableBuilder.new(@panel, options.merge(questionnaire: @panel.questionnaire,
                                                               default_question_options: @default_question_options))
        table_builder.instance_eval(&block) if block
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

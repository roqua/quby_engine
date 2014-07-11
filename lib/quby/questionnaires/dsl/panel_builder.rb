require 'quby/questionnaires/entities'

module Quby
  module Questionnaires
    module DSL
      class PanelBuilder < Base
        attr_reader :title
        attr_reader :questionnaire

        def initialize(title, options = {})
          @panel = Entities::Panel.new(options.merge(title: title, items: []))
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
          @panel.items << Entities::Text.new(value.to_s, options)
        end

        def html(value)
          @panel.items << Entities::Text.new('', html_content: value.to_s)
        end

        def raw_html(value)
          @panel.items << Entities::Text.new('', raw_content: value.to_s)
        end

        def default_question_options(options = {})
          @default_question_options = @default_question_options.merge(options)
        end

        def question(key, options = {}, &block)
          if @panel.questionnaire.key_in_use? key
            fail "#{@panel.questionnaire.key}:#{key}: A question or option with input key #{key} is already defined."
          end

          options = @default_question_options.merge(options).merge(questionnaire: @panel.questionnaire)
          question = QuestionBuilder.build(key, options, &block)

          @questionnaire.register_question(key, question)
          @panel.items << question
        end

        def table(options = {}, &block)
          table_builder = TableBuilder.new(@panel, options.merge(questionnaire: @panel.questionnaire,
                                                                 default_question_options: @default_question_options))
          table_builder.instance_eval(&block) if block
        end
      end
    end
  end
end

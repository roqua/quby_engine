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
          @custom_methods = options[:custom_methods] || {}
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
          options = @default_question_options.merge(options).merge(questionnaire: @panel.questionnaire)

          check_question_keys_uniqueness key, options, @questionnaire

          question = QuestionBuilder.build(key, options, &block)

          @questionnaire.register_question(question)
          @panel.items << question
        end

        def table(options = {}, &block)
          table_builder = TableBuilder.new(@panel, options.merge(questionnaire: @panel.questionnaire,
                                                                 default_question_options: @default_question_options,
                                                                 custom_methods: @custom_methods))
          table_builder.instance_eval(&block) if block
        end

        def method_missing(method_sym, *args, &block)
          if @custom_methods.key? method_sym
            instance_exec(*args, &@custom_methods[method_sym])
          else
            super
          end
        end

        def respond_to_missing?(method_name, include_private = false)
          @custom_methods.key?(method_name) || super
        end
      end
    end
  end
end

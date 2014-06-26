require 'quby/items/question'
require 'quby/question_option'

module Quby
  module DSL
    class QuestionBuilder
      attr_reader :key
      attr_reader :title
      attr_reader :type
      attr_reader :parent
      attr_reader :questionnaire

      def initialize(key, options = {})
        question_type = options[:type] or fail "Question #{key} from #{options[:questionnaire].key} has no type!"
        @question = Quby::Items::Question.for(question_type).new(key, options)
        @default_question_options = options[:default_question_options] || {}
        @questionnaire = options[:questionnaire]
        @title_question = nil
      end

      def build
        if @title_question
          @question.options.last.questions << @title_question
          @title_question = nil
        end
        @question
      end

      def title(value)
        @question.title = value
      end

      def inner_title(value)
        question_option = QuestionOption.new(nil, @question, inner_title: true, description: value)
        @question.options << question_option
      end

      def description(value)
        @question.description = value
      end

      def presentation(value)
        @question.presentation = value
      end

      def hidden(value = true)
        @question.hidden = value
      end

      def lines(value)
        @question.lines = value
      end

      def unit(value)
        @question.unit = value
      end

      def size(value)
        @question.size = value
      end

      def label(value)
        @question.labels << value
      end

      # deprecated
      def left_label(value)
        @question.labels.unshift(value)
      end

      # deprecated
      def right_label(value)
        @question.labels << value
      end

      def option(key, options = {}, &block)
        question_option = QuestionOption.new(key, @question, options)
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

        question_builder = QuestionBuilder.new(key, options)
        question_builder.instance_eval(&block) if block
        question = question_builder.build

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

        question_builder = QuestionBuilder.new(key, options)
        question_builder.instance_eval(&block) if block
        question = question_builder.build

        @questionnaire.question_hash[key] = question
        @question.options.last.questions << question
      end

      def depends_on(keys)
        @question.set_depends_on(keys)
      end

      def validates_format_with(regexp, options = {})
        @question.validations ||= []
        @question.validations << {type: :regexp, matcher: regexp}.reverse_merge(options)
      end

      def validates_presence_of_answer(options = {})
        @question.validations ||= []
        @question.validations << {type: :requires_answer}.reverse_merge(options)
      end

      def validates_minimum(value, options = {})
        @question.validations ||= []
        @question.validations << {type: :minimum, value: value}.reverse_merge(options)
      end

      def validates_maximum(value, options = {})
        @question.validations ||= []
        @question.validations << {type: :maximum, value: value}.reverse_merge(options)
      end

      def validates_in_range(range, options = {})
        @question.validations ||= []
        @question.validations << {type: :minimum, value: range.first}.reverse_merge(options)
        @question.validations << {type: :maximum, value: range.last}.reverse_merge(options)
      end
    end
  end
end

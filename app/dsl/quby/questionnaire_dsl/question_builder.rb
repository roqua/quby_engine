module Quby
  module QuestionnaireDsl
    class QuestionBuilder
      attr_reader :key
      attr_reader :title
      attr_reader :type
      attr_reader :parent
      attr_reader :questionnaire

      def initialize(key, options = {})
        @question = Quby::Items::Question.new(key, options)
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
        op = QuestionOption.new(nil, @question, :inner_title => true, :description => value)
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

      def left_label(value)
        @question.left_label = value
      end

      def right_label(value)
        @question.right_label = value
      end

      def option(key, options = {}, &block)
        raise "#{questionnaire.key}: Option with key #{key} already defined. Keys must be unique within a question." if @question.options.find { |i| i.key == key }
        op = QuestionOption.new(key, @question, options)

        if @question.type == :check_box
          raise "#{questionnaire.key}: Question with key #{key} already defined. Checkbox option keys must be completely unique." if @questionnaire.question_hash[key]
          @questionnaire.question_hash[key] = op
        end

        instance_eval(&block) if block
      end

      def title_question(key, options = {}, &block)
        raise "Question key: #{key} repeated!" if @questionnaire.question_hash[key]
        options = @default_question_options.merge({:depends_on => @question.key, :questionnaire => @questionnaire, :parent => @question, :presentation => :next_to_title}.merge(options))

        q = QuestionBuilder.new(key, options)
        q.instance_eval(&block) if block
        question = q.build

        @questionnaire.question_hash[key] = question
        @title_question = question
      end

      def question(key, options = {}, &block)
        raise "Question key: #{key} repeated!" if @questionnaire.question_hash[key]

        q = QuestionBuilder.new(key, @default_question_options.merge(options.merge(:questionnaire => @questionnaire, :parent => @question, :parent_option_key => @question.options.last.key)))
        q.instance_eval(&block) if block
        question = q.build
        @questionnaire.question_hash[key] = question
        @question.options.last.questions << question
      end

      def depends_on(keys)
        @question.set_depends_on(keys, @questionnaire)
      end

      def validates_format_with(regexp, options = {})
        @question.validations ||= []
        @question.validations << {:type => :regexp, :matcher => regexp}.reverse_merge(options)
      end

      def validates_presence_of_answer(options = {})
        @question.validations ||= []
        @question.validations << {:type => :requires_answer}.reverse_merge(options)
      end

      def validates_minimum(value, options = {})
        @question.validations ||= []
        @question.validations << {:type => :minimum, :value => value}.reverse_merge(options)
      end

      def validates_maximum(value, options = {})
        @question.validations ||= []
        @question.validations << {:type => :maximum, :value => value}.reverse_merge(options)
      end

      def validates_in_range(range, options = {})
        @question.validations ||= []
        @question.validations << {:type => :minimum, :value => range.first}.reverse_merge(options)
        @question.validations << {:type => :maximum, :value => range.last}.reverse_merge(options)
      end
    end
  end
end

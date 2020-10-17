# frozen_string_literal: true

module Quby
  module Compiler
    module DSL
      module Questions
        class Base < ::Quby::Compiler::DSL::Base
          attr_reader :key
          attr_reader :title
          attr_reader :type
          attr_reader :questionnaire

          def initialize(key, options = {})
            @questionnaire = options[:questionnaire]
          end

          def build
            @question
          end

          def title(value)
            @question.title = value
          end

          def context_free_title(value)
            @question.context_free_title = value
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

          def depends_on(keys)
            @question.set_depends_on(keys)
          end

          def default_position(value)
            @question.default_position = value
          end

          # TODO not referenced in definitions?
          def validates_presence_of_answer(options = {})
            @question.validations ||= []
            @question.validations << {type: :requires_answer}.reverse_merge(options)
          end
        end

        module RegexpValidations
          def validates_format_with(regexp, options = {})
            @question.validations ||= []
            @question.validations << {type: :regexp, matcher: regexp}.reverse_merge(options)
          end
        end

        module MinMaxValidations
          def validates_minimum(value, options = {})
            subtype = @question.type == :date ? :date : :number
            @question.validations ||= []
            @question.validations << {type: :minimum, value: value, subtype: subtype}.reverse_merge(options)
          end

          def validates_maximum(value, options = {})
            subtype = @question.type == :date ? :date : :number
            @question.validations ||= []
            @question.validations << {type: :maximum, value: value, subtype: subtype}.reverse_merge(options)
          end

          def validates_in_range(range, options = {})
            subtype = @question.type == :date ? :date : :number
            @question.validations ||= []
            @question.validations << {type: :minimum, value: range.first, subtype: subtype}.reverse_merge(options)
            @question.validations << {type: :maximum, value: range.last, subtype: subtype}.reverse_merge(options)
          end
        end

        module Labeling
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
        end

        module MultipleChoice
          def option(key, options = {}, &block)
            question_option = Entities::QuestionOption.new(key, @question, options)
            if @questionnaire.key_in_use?(question_option.input_key) || @question.key_in_use?(question_option.input_key)
              fail "#{questionnaire.key}:#{@question.key}:#{question_option.key}: " \
                    "A question or option with input key #{question_option.input_key} is already defined."
            end

            @question.options << question_option
            instance_eval(&block) if block
          end
        end

        module Subquestions
          def initialize(key, options = {}, &block)
            super
            @default_question_options = options[:default_question_options] || {}
            @title_question = nil
          end

          def build
            if @title_question
              @question.options.last.questions << @title_question
              @title_question = nil
            end

            super
          end

          def title_question(key, options = {}, &block)
            options = @default_question_options.merge({depends_on: @question.key,
                                                       questionnaire: @questionnaire,
                                                       parent: @question,
                                                       presentation: :next_to_title,
                                                       allow_blank_titles: @question.allow_blank_titles}.merge(options))

            check_question_keys_uniqueness key, options, @questionnaire

            question = QuestionBuilder.build(key, options, &block)

            @questionnaire.register_question(question)
            @title_question = question
          end

          def question(key, options = {}, &block)
            options = @default_question_options.merge(options)
                                               .merge(questionnaire: @questionnaire,
                                                      parent: @question,
                                                      parent_option_key: @question.options.last.key)

            check_question_keys_uniqueness key, options, @questionnaire

            question = QuestionBuilder.build(key, options, &block)

            @questionnaire.register_question(question)
            @question.options.last.questions << question
          end
        end

        module InnerTitles
          def inner_title(value)
            question_option = Entities::QuestionOption.new(nil, @question, inner_title: true, description: value)
            @question.options << question_option
          end
        end

        module Units
          def unit(value)
            @question.unit = value
          end
        end

        module Sizes
          def size(value)
            @question.size = value
          end
        end
      end
    end
  end
end
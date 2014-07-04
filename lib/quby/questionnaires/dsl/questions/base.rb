module Quby
  module Questionnaires
    module DSL
      module Questions
        class Base < ::Quby::Questionnaires::DSL::Base
          attr_reader :key
          attr_reader :title
          attr_reader :type
          attr_reader :parent
          attr_reader :questionnaire

          def initialize(key, options = {})
            question_type = options[:type] or fail "Question #{key} from #{options[:questionnaire].key} has no type!"
            @question = Entities::Items::Question.for(question_type).new(key, options)
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

          def depends_on(keys)
            @question.set_depends_on(keys)
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
  end
end

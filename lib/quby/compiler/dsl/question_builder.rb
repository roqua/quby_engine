# frozen_string_literal: true

require 'quby/compiler/entities'

require 'quby/compiler/dsl/questions/base'
require 'quby/compiler/dsl/questions/checkbox_question_builder'
require 'quby/compiler/dsl/questions/date_question_builder'
require 'quby/compiler/dsl/questions/deprecated_question_builder'
require 'quby/compiler/dsl/questions/float_question_builder'
require 'quby/compiler/dsl/questions/integer_question_builder'
require 'quby/compiler/dsl/questions/radio_question_builder'
require 'quby/compiler/dsl/questions/select_question_builder'
require 'quby/compiler/dsl/questions/string_question_builder'
require 'quby/compiler/dsl/questions/text_question_builder'

module Quby
  module Compiler
    module DSL
      module QuestionBuilder
        include Helpers
        BUILDERS = {
          'string'    => Questions::StringQuestionBuilder,
          'textarea'  => Questions::TextQuestionBuilder,
          'integer'   => Questions::IntegerQuestionBuilder,
          'float'     => Questions::FloatQuestionBuilder,
          'radio'     => Questions::RadioQuestionBuilder,
          'scale'     => Questions::RadioQuestionBuilder,
          'select'    => Questions::SelectQuestionBuilder,
          'check_box' => Questions::CheckboxQuestionBuilder,
          'date'      => Questions::DateQuestionBuilder,
          'hidden'    => Questions::DeprecatedQuestionBuilder
        }

        def self.build(key, options = {}, &block)
          BUILDERS.fetch(options.fetch(:type).to_s).build(key, options, &block)
        end
      end
    end
  end
end

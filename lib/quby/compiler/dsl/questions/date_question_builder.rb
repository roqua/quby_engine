# frozen_string_literal: true

module Quby
  module Compiler
    module DSL
      module Questions
        class DateQuestionBuilder < Base
          include MinMaxValidations

          def initialize(key, options = {}, &block)
            super
            @question = Entities::Questions::DateQuestion.new(key, options)
          end
        end
      end
    end
  end
end

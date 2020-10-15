# frozen_string_literal: true

module Quby
  module Compiler
    module DSL
      module Questions
        class DeprecatedQuestionBuilder < Base
          include MultipleChoice

          def initialize(key, options = {}, &block)
            super
            @question = Entities::Questions::DeprecatedQuestion.new(key, options)
          end
        end
      end
    end
  end
end

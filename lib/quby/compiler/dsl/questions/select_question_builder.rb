# frozen_string_literal: true

module Quby
  module Compiler
    module DSL
      module Questions
        class SelectQuestionBuilder < Base
          include MultipleChoice

          def initialize(key, options = {}, &block)
            super
            @question = Entities::Questions::SelectQuestion.new(key, options)
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module Quby
  module Compiler
    module DSL
      module Questions
        class CheckboxQuestionBuilder < Base
          include MultipleChoice
          include Subquestions
          include InnerTitles

          def initialize(key, options = {}, &block)
            super
            @question = Entities::Questions::CheckboxQuestion.new(key, options)
          end
        end
      end
    end
  end
end

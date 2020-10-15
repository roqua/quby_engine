# frozen_string_literal: true

module Quby
  module Compiler
    module DSL
      module Questions
        class FloatQuestionBuilder < Base
          include MinMaxValidations
          include Labeling
          include Units
          include Sizes

          def initialize(key, options = {}, &block)
            super
            @question = Entities::Questions::FloatQuestion.new(key, options)
          end
        end
      end
    end
  end
end

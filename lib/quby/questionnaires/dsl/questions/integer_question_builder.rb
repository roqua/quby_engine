module Quby
  module Questionnaires
    module DSL
      module Questions
        class IntegerQuestionBuilder < Base
          include MinMaxValidations
          include Labeling
          include Units
          include Sizes

          def initialize(key, options = {}, &block)
            super
            @question = Entities::Questions::IntegerQuestion.new(key, options)
          end
        end
      end
    end
  end
end

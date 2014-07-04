module Quby
  module Questionnaires
    module DSL
      module Questions
        class IntegerQuestionBuilder < Base
          include MinMaxValidations
          include Labeling
          include Units
          include Sizes
        end
      end
    end
  end
end

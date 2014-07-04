module Quby
  module Questionnaires
    module DSL
      module Questions
        class StringQuestionBuilder < Base
          include RegexpValidations
          include Units
          include Sizes
        end
      end
    end
  end
end

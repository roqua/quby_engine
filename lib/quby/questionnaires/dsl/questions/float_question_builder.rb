module Quby
  module Questionnaires
    module DSL
      module Questions
        class FloatQuestionBuilder < Base
          include MinMaxValidations
          include Labeling
        end
      end
    end
  end
end

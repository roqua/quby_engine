module Quby
  module Questionnaires
    module DSL
      module Questions
        class DateQuestionBuilder < Base
          include MinMaxValidations
        end
      end
    end
  end
end

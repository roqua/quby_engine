module Quby
  module Questionnaires
    module DSL
      module Questions
        class TextQuestionBuilder < Base
          include RegexpValidations

          def lines(value)
            @question.lines = value
          end
        end
      end
    end
  end
end

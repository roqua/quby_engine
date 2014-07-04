module Quby
  module Questionnaires
    module DSL
      module Questions
        class TextQuestionBuilder < Base
          include RegexpValidations
        end
      end
    end
  end
end

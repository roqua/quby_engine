module Quby
  module Questionnaires
    module DSL
      module Questions
        class StringQuestionBuilder < Base
          include RegexpValidations
        end
      end
    end
  end
end

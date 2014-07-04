module Quby
  module Questionnaires
    module DSL
      module Questions
        class SelectQuestionBuilder < Base
          include MultipleChoice
        end
      end
    end
  end
end

module Quby
  module Questionnaires
    module DSL
      module Questions
        class CheckboxQuestionBuilder < Base
          include MultipleChoice
          include Subquestions
          include InnerTitles
        end
      end
    end
  end
end

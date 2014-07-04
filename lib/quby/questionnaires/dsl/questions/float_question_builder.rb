module Quby
  module Questionnaires
    module DSL
      module Questions
        class FloatQuestionBuilder < Base
          def label(value)
            @question.labels << value
          end

          # deprecated
          def left_label(value)
            @question.labels.unshift(value)
          end

          # deprecated
          def right_label(value)
            @question.labels << value
          end
        end
      end
    end
  end
end

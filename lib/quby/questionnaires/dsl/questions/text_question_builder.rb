module Quby
  module Questionnaires
    module DSL
      module Questions
        class TextQuestionBuilder < Base
          include RegexpValidations

          def initialize(key, options = {}, &block)
            super
            @question = Entities::Questions::TextQuestion.new(key, options)
          end

          def lines(value)
            @question.lines = value
          end
        end
      end
    end
  end
end

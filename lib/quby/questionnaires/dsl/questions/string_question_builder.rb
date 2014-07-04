module Quby
  module Questionnaires
    module DSL
      module Questions
        class StringQuestionBuilder < Base
          include RegexpValidations
          include Units
          include Sizes

          def initialize(key, options = {}, &block)
            super
            @question = Entities::Questions::StringQuestion.new(key, options)
          end
        end
      end
    end
  end
end

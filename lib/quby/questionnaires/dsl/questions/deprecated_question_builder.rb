module Quby
  module Questionnaires
    module DSL
      module Questions
        class DeprecatedQuestionBuilder < Base
          def initialize(key, options = {}, &block)
            super
            @question = Entities::Questions::DeprecatedQuestion.new(key, options)
          end
        end
      end
    end
  end
end

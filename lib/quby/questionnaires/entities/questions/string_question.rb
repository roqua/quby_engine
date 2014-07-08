module Quby
  module Questionnaires
    module Entities
      module Questions
        class StringQuestion < Question
          def as_json(options = {})
            super.merge(autocomplete: @autocomplete)
          end
        end
      end
    end
  end
end

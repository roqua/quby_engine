# frozen_string_literal: true

module Quby
  module Questionnaires
    module Entities
      module Questions
        class FloatQuestion < Question
          def size
            @size || 30
          end
        end
      end
    end
  end
end

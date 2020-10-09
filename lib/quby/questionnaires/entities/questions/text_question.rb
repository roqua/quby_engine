# frozen_string_literal: true

module Quby
  module Questionnaires
    module Entities
      module Questions
        class TextQuestion < Question
          def as_json(options = {})
            super.merge(autocomplete: @autocomplete, lines: lines, cols: cols)
          end
        end
      end
    end
  end
end

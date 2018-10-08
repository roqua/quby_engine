# frozen_string_literal: true

module Quby
  module Questionnaires
    module Entities
      module Questions
        class DeprecatedQuestion < Question
          def hidden?
            true
          end

          def as_json(options = {})
            super.merge(options: @options.as_json)
          end
        end
      end
    end
  end
end

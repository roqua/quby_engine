# frozen_string_literal: true

module Quby
  module Compiler
    module Entities
      module Questions
        class StringQuestion < Question
          def as_json(options = {})
            super.merge(autocomplete: @autocomplete, size: @size || 30)
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module Quby
  module Compiler
    module Entities
      module Questions
        class IntegerQuestion < Question
          def size
            @size || 30
          end
        end
      end
    end
  end
end

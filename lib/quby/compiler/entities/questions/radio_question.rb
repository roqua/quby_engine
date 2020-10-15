# frozen_string_literal: true

module Quby
  module Compiler
    module Entities
      module Questions
        class RadioQuestion < Question
          def as_json(options = {})
            super.merge(options: @options.as_json)
          end

          def codebook_output_type
            :radio
          end
        end
      end
    end
  end
end

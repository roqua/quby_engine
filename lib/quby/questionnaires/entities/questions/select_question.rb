module Quby
  module Questionnaires
    module Entities
      module Questions
        class SelectQuestion < Items::Question
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

require 'quby/questionnaires/entities/charting/chart'

module Quby
  module Questionnaires
    module Entities
      module Charting
        class LineChart < Chart
          attribute :y_label,                    String
          attribute :tonality,                   Symbol, default: :lower_is_better
          attribute :baseline,                   Proc
          attribute :clinically_relevant_change, Float

          def tonality=(value)
            fail "Invalid tonality: #{value}" unless [:higher_is_better, :lower_is_better].include?(value)
            super
          end
        end
      end
    end
  end
end

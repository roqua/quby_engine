# frozen_string_literal: true

require 'quby/questionnaires/entities/charting/chart'

module Quby
  module Questionnaires
    module Entities
      module Charting
        class LineChart < Chart
          attribute :y_label,                    Types::String
          attribute :tonality,                   Types::Symbol.default(:lower_is_better)
          attribute :baseline,                   Types::Object # Proc
          attribute :clinically_relevant_change, Types::Float

          def tonality=(value)
            fail "Invalid tonality: #{value}" unless [:higher_is_better, :lower_is_better].include?(value)
            super
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'quby/questionnaires/entities/charting/chart'

module Quby
  module Questionnaires
    module Entities
      module Charting
        class LineChart < Chart
          attr_accessor :y_label, :tonality, :baseline, :clinically_relevant_change

          def initialize(key, y_label: nil, tonality: :lower_is_better, baseline: nil, clinically_relevant_change: nil, **kwargs)
            super(key, **kwargs)
            self.y_label = y_label
            self.tonality = tonality
            self.baseline = baseline
            self.clinically_relevant_change = clinically_relevant_change
          end

          #attribute :y_label,                    String
          #attribute :tonality,                   Symbol, default: :lower_is_better
          #attribute :baseline,                   Proc
          #attribute :clinically_relevant_change, Float

          def tonality=(value)
            fail "Invalid tonality: #{value}" unless [:higher_is_better, :lower_is_better].include?(value)
            @tonality = value
          end
        end
      end
    end
  end
end

require 'quby/questionnaires/entities/charting/chart'

module Quby
  module Questionnaires
    module Entities
      module Charting
        class RadarChart < Chart
          attribute :y_range,       Range
          attribute :tick_interval, Float
        end
      end
    end
  end
end

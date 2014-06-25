require 'quby/charting/chart'

module Quby
  module Charting
    class RadarChart < Chart
      attribute :y_range,       Range
      attribute :tick_interval, Float
    end
  end
end

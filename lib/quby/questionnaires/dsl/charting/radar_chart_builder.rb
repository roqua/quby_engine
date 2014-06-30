require 'quby/questionnaires/entities/charting/radar_chart'
require_relative 'chart_builder'

module Quby
  module Questionnaires
    module DSL
      class RadarChartBuilder < ChartBuilder
        set_chart_class(Entities::Charting::RadarChart)

        def range(range)
          @chart.y_range = range
        end

        def tick_interval(tick_interval)
          @chart.tick_interval = tick_interval
        end
      end
    end
  end
end

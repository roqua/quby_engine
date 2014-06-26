require 'quby/charting/radar_chart'
require 'quby/questionnaire_dsl/chart_builder'

module Quby
  module DSL
    class RadarChartBuilder < ChartBuilder
      set_chart_class(::Quby::Charting::RadarChart)

      def range(range)
        @chart.y_range = range
      end

      def tick_interval(tick_interval)
        @chart.tick_interval = tick_interval
      end
    end
  end
end

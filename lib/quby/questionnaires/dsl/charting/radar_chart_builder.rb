require 'quby/questionnaires/entities/charting/radar_chart'
require_relative 'chart_builder'

module Quby
  module Questionnaires
    module DSL
      class RadarChartBuilder < ChartBuilder
        set_chart_class(Entities::Charting::RadarChart)

        def plotline(value, color)
          @chart.plotlines << {value: value, color: color, width: 1, zIndex: 3}
        end
      end
    end
  end
end

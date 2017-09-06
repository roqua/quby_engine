require 'quby/questionnaires/entities/charting/radar_chart'
require_relative 'chart_builder'

module Quby
  module Questionnaires
    module DSL
      class RadarChartBuilder < ChartBuilder
        set_chart_class(Entities::Charting::RadarChart)

        def plotline(value, color, text = '')
          label = text.present? ? {text: text, y: 10, style: {color: color}} : {}
          @chart.plotlines << {value: value, color: color, width: 1, zIndex: 3, label: label}
        end
      end
    end
  end
end

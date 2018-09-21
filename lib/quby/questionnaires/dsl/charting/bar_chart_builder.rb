# frozen_string_literal: true

require 'quby/questionnaires/entities/charting/bar_chart'
require_relative 'chart_builder'

module Quby
  module Questionnaires
    module DSL
      class BarChartBuilder < ChartBuilder
        set_chart_class(Entities::Charting::BarChart)

        def plotline(value, color)
          @chart.plotlines << {value: value, color: color, width: 1, zIndex: 3}
        end
      end
    end
  end
end

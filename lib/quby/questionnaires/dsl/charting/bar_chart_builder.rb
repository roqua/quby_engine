require 'quby/questionnaires/entities/charting/bar_chart'
require_relative 'chart_builder'

module Quby
  module Questionnaires
    module DSL
      class BarChartBuilder < ChartBuilder
        set_chart_class(::Quby::Questionnaires::Entities::Charting::BarChart)
      end
    end
  end
end

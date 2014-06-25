require 'quby/charting/bar_chart'
require 'quby/questionnaire_dsl/chart_builder'

module Quby
  module QuestionnaireDsl
    class BarChartBuilder < ChartBuilder
      set_chart_class(::Quby::Charting::BarChart)
    end
  end
end

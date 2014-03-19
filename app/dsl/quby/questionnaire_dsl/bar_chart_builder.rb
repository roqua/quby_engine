module Quby
  module QuestionnaireDsl
    class BarChartBuilder < ChartBuilder
      set_chart_class(::Quby::Charting::BarChart)
    end
  end
end

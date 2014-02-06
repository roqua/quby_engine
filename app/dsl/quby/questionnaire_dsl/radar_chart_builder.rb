module Quby
  module QuestionnaireDsl
    class RadarChartBuilder < ChartBuilder
      set_chart_class(::Quby::Charting::RadarChart)
    end
  end
end
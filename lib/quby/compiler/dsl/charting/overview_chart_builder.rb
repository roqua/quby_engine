require 'quby/compiler/entities/charting/overview_chart'
require_relative 'chart_builder'

module Quby
  module Compiler
    module DSL
      class OverviewChartBuilder < ChartBuilder
        set_chart_class(Entities::Charting::OverviewChart)

        def initialize(questionnaire, options = {})
          @questionnaire = questionnaire
          @chart = self.class.chart_class.new
        end

        def subscore(key)
          @chart.subscore = key
        end

        def y_max(value)
          @chart.y_max = value
        end

        def validate!
          fail ArgumentError, "subscore not specified" unless @chart.subscore.present?
          fail ArgumentError, "y_max not specified" unless @chart.y_max.present?
          true
        end
      end
    end
  end
end

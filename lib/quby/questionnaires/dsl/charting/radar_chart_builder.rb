# frozen_string_literal: true

require 'quby/questionnaires/entities/charting/radar_chart'
require_relative 'chart_builder'

module Quby
  module Questionnaires
    module DSL
      class RadarChartBuilder < ChartBuilder
        set_chart_class(Entities::Charting::RadarChart)
      end
    end
  end
end

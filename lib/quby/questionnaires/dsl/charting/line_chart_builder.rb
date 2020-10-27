# frozen_string_literal: true

require 'quby/questionnaires/entities/charting/line_chart'
require_relative 'chart_builder'

module Quby
  module Questionnaires
    module DSL
      class LineChartBuilder < ChartBuilder
        set_chart_class(Entities::Charting::LineChart)

        def y_axis_label(label)
          @chart.y_label = label
        end

        def tonality(value)
          @chart.tonality = value
        end

        # value - Number or a hash `{from_age..to_age => {female: 5, default: 4}, ..}`
        # block - deprecated.
        def baseline(value = nil, &block)
          unless value.nil? ^ block.nil?
            fail ArgumentError, "Must give either value or a block"
          end

          if value && value.is_a?(Hash)
            @chart.baseline = ->(age, gender) {
              gender_lookup = value.find { |age_match, _v| age_match === age }.last.stringify_keys
              gender_lookup[gender.to_s] || gender_lookup['default']
            }
          elsif value
            @chart.baseline = ->(age, gender) { value }
          end

          if block
            if block.arity != 2
              fail ArgumentError, "Given block must take two arguments"
            end
            @chart.baseline = block
          end
        end

        def clinically_relevant_change(value)
          @chart.clinically_relevant_change = value
        end

        def validate!
          fail "Chart #{@chart.key} has no range specified" unless @chart.y_range
        end
      end
    end
  end
end

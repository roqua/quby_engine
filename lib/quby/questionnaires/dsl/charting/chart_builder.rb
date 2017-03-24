require 'quby/questionnaires/entities'

module Quby
  module Questionnaires
    module DSL
      class ChartBuilder
        # rubocop:disable AccessorMethodName
        def self.set_chart_class(chart_class)
          @chart_class = chart_class
        end
        # rubocop:enable AccessorMethodName

        def self.chart_class
          @chart_class
        end

        def initialize(questionnaire, key, options = {})
          @chart = self.class.chart_class.new(key, options)
          @questionnaire = questionnaire
        end

        def title(title)
          @chart.title = title
        end

        def range(range)
          @chart.y_range = range
        end

        def tick_interval(tick_interval)
          @chart.tick_interval = tick_interval
        end

        def y_categories(y_categories)
          @chart.y_categories = y_categories
        end

        def y_range_categories(*y_range_categories)
          if y_range_categories.length.even? || y_range_categories.length < 3
            fail "#{@chart.key} y_range_categories should be of the form (0, 'label 0-10', 10, 'label 10-20', 20)"
          end

          # converts [0, 'label 0-10', 10, 'label 10-20', 20] into [0, 'label 0-10', 10, 10, 'label 10-20', 20]
          expanded_categories =
            y_range_categories[0..1] +
            y_range_categories[2...-1].each_slice(2).flat_map { |(start_at, label)| [start_at, start_at, label] } +
            y_range_categories[-1..-1]

          # converts [0, 'label 0-10', 10, 10, 'label 10-20', 20] into
          # {(0.0...10.0) => 'label 0-10', (10.0..20.0) => 'label 10-20'}
          range_hash = {}
          expanded_categories.each_slice(3).each_with_index.map do |(start_point, label, end_point), index|
            if index < expanded_categories.length / 3 - 1
              range_hash[start_point.to_f...end_point.to_f] = label
            else # last range should be inclusive its end point
              range_hash[start_point.to_f..end_point.to_f] = label
            end
          end
          @chart.y_range_categories = range_hash
        end

        def plot(key, options = {})
          unless plottable = @questionnaire.find_plottable(key)
            fail "Questionnaire #{@questionnaire.key} chart #{@chart.key} references unknown score or question #{key}"
          end

          configure_options plottable, options

          @chart.plottables << Entities::Charting::Plottable.new(plottable.key, options)
        end

        def chart_type(type)
          @chart.chart_type = type
        end

        def build(&block)
          instance_eval(&block)
          validate!
          @chart
        end

        def validate!
          if @chart.y_categories.present? && @chart.y_range.present? &&
             @chart.y_range != (0..(@chart.y_categories.count - 1))
            fail ArgumentError, 'Y_categories size and range do not match'
          end

          true
        end

        private

        def configure_options(plottable, options)
          case plottable
          when Entities::ScoreCalculation
            options.reverse_merge! plottable.options
          when Entities::Question
            options[:label] ||= plottable.title
          end
          options[:questionnaire_key] = @questionnaire.key
        end
      end
    end
  end
end

# frozen_string_literal: true

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
          @chart.y_range_categories = RangeCategories.new(*y_range_categories).as_range_hash
        end

        def plotband(from, to, color)
          @chart.plotbands << {from: from, to: to, color: color}
        end

        def plotline(value, color)
          @chart.plotlines << {value: value, color: color}
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

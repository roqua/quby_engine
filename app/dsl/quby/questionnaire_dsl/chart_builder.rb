module Quby
  module QuestionnaireDsl
    class ChartBuilder
      def self.set_chart_class(chart_class)
        @chart_class = chart_class
      end

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

      def plot(key, plotted_key = :value, options = {})
        plottable = @questionnaire.find_plottable(key)
        unless plottable
          raise "Questionnaire #{@questionnaire.key} chart #{@chart.key} references unknown score or question #{key}"
          return
        end
        label = options[:label] || plottable.label
        @chart.plottables << Quby::Charting::Plottable.new(plottable.key, label: label, plotted_key: plotted_key)
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
        true
      end
    end
  end
end
module Quby
  module QuestionnaireDsl
    class LineChartBuilder
      def initialize(key, options = {})
        @chart = ::Quby::Charting::LineChart.new(key, options = {})
      end

      def title(title)
        @chart.title = title
      end

      def y_axis_label(label)
        @chart.y_label = label
      end

      def range(range)
        @chart.y_range = range
      end

      def stepsize(value)
        @chart.y_stepsize = value
      end

      def tonality(value)
        @chart.tonality = value
      end

      def baseline(value)
        @chart.baseline = value
      end

      def clinically_relevant_change(value)
        @chart.clinically_relevant_change = value
      end

      def build(&block)
        instance_eval &block
        @chart
      end
    end
  end
end
module Quby
  module QuestionnaireDsl
    class LineChartBuilder
      def initialize(key, options = {})
        @chart = LineChart.new(key, options = {})
      end

      def title(title)
        @chart.title = title
      end

      def build(&block)
        instance_eval &block
        @chart
      end
    end
  end
end
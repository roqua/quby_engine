module Quby
  module QuestionnaireDsl
    class LineChartBuilder < ChartBuilder
      set_chart_class(::Quby::Charting::LineChart)

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

      def baseline(value = nil, &block)
        if (not value and not block) or (value and block)
          raise ArgumentError, "Must give either value or a block"
        end

        if value
          @chart.baseline = lambda { |age, gender| value }
        end

        if block
          if block.arity != 2
            raise ArgumentError, "Given block must take two arguments"
          end
          @chart.baseline = block
        end
      end

      def clinically_relevant_change(value)
        @chart.clinically_relevant_change = value
      end

      def validate!
        raise "Chart #{@chart.key} has no range specified" unless @chart.y_range
      end
    end
  end
end
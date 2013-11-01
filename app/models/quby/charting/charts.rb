module Quby
  module Charting
    class Charts
      include Enumerable

      def initialize
        @charts = []
      end

      def add(chart)
        raise "Duplicate chart: #{chart.key} already exists!" if find(chart.key)
        @charts << chart
      end

      def find(key)
        @charts.find { |i| i.key == key }
      end

      def each(*args, &block)
        @charts.each(*args, &block)
      end

      def size
        @charts.size
      end
    end
  end
end
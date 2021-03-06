# frozen_string_literal: true

module Quby
  module Questionnaires
    module Entities
      module Charting
        class Charts
          include Enumerable

          def initialize
            @charts = []
          end

          def overview
            @overview_chart
          end

          def overview=(chart)
            @overview_chart = chart
          end

          def add(chart)
            fail "Duplicate chart: #{chart.key} already exists!" if find(chart.key)
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
  end
end

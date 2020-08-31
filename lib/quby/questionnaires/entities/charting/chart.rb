# frozen_string_literal: true

module Quby
  module Questionnaires
    module Entities
      module Charting
        class Chart
          # @return [Symbol]
          attr_accessor :key

          # @return [String]
          attr_accessor :title

          # @return [Array]
          attr_accessor :plottables

          # If y_categories are defined, plottable values should correspond to
          # values from this array and the graph will be plotted with
          # corresponding y axis categories example (icl_r):
          #
          #   ["Zeer laag", "Laag", "Gemiddeld", "Hoog", "Zeer Hoog"]
          #
          # (caution, capitalization oddity)
          #
          # NB: only implemented for bar charts on the roqua side
          #
          # @return [Array]
          attr_accessor :y_categories

          # If y_range_categories are defined, plottable values should fall in
          # the ranges that compose the keys of this hash. The chart will label
          # these ranges of y_values with the corresponding value in the hash
          # on the y axis. For example:
          #
          #   {
          #     (0.0...30.0) => "Zeer laag",
          #     (30.0...40.0) => "Laag",
          #     (40.0...60.0) => "Gemiddeld",
          #     (60.0...70.0) => "Hoog",
          #     (70.0..100.0) => "Zeer hoog"
          #   }
          #
          # NB: .. is inclusive the last value in the range, ... is exclusive.
          #
          # ChartBuilder#y_range_categories massages its parameters into this
          # format. Only implemented for line charts on the RoQua side.
          #
          # @return [Hash<Range, String>]
          attr_accessor :y_range_categories

          # @return [Symbol]
          attr_accessor :chart_type

          # @return [Range]
          attr_accessor :y_range

          # @return [Float]
          attr_accessor :tick_interval

          # @return [Array]
          attr_accessor :plotbands

          def initialize(key, title: nil, plottables: nil, y_categories: nil, y_range_categories: nil, chart_type: nil, y_range: nil, tick_interval: nil, plotbands: nil)
            self.key = key.to_sym
            self.title = title
            self.plottables = plottables || []
            self.y_categories = y_categories
            self.y_range_categories = y_range_categories
            self.chart_type = chart_type
            self.y_range = y_range
            self.tick_interval = tick_interval
            self.plotbands = plotbands || []
          end

          def type
            self.class.name.to_s.demodulize.underscore
          end

          def y_range
            @y_range || @y_range = default_y_range
          end

          def chart_type=(value)
            @chart_type = value&.to_sym
          end

          def default_y_range
            # when there are y_categories, the y_range should match the
            # number of categories (validated in chart_builder#validate!)
            (0..(y_categories.count - 1)) if y_categories.present?
            # otherwise, nil is allowed as a y_range
          end
        end
      end
    end
  end
end

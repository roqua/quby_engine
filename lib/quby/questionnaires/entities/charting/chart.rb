# frozen_string_literal: true

require 'dry-struct'
require_relative './plottable'

module Quby
  module Questionnaires
    module Entities
      module Charting
        class Chart < Dry::Struct
          transform_keys(&:to_sym)

          attribute :key, Types::Coercible::Symbol
          attribute? :title, Types::String.optional
          attribute? :plottables, Types::Array.of(Plottable)

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
          attribute? :y_categories, Types::Array.of(Types::String).optional

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
          attribute? :y_range_categories, Types::Hash.map(Types::Range, Types::String).optional

          attribute? :chart_type, Types::Coercible::Symbol.optional
          attribute? :y_range, Types::Range.optional
          attribute? :tick_interval, Types::Float.optional
          attribute :plotbands, Types::Array.of(Types::Plotband).default { [] }

          def y_range
            attributes[:y_range] || default_y_range
          end

          def type
            self.class.name.to_s.demodulize.underscore
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

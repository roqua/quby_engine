module Quby
  module Charting
    class Plottable  < Struct.new(:key, :label, :plotted_key)
      def initialize(key, options = {})
        key         = key
        label       = options[:label]
        plotted_key = options.fetch(:plotted_key) { :value }
        super(key, label, plotted_key)
      end
    end
  end
end

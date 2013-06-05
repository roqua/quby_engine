module Quby
  module Charting
    class Plottable  < Struct.new(:key, :label, :plotted_key, :global)
      def initialize(key, options = {})
        key         = key
        label       = options[:label]
        plotted_key = options.fetch(:plotted_key) { :value }
        global      = options[:global]
        super(key, label, plotted_key, global)
      end
    end
  end
end

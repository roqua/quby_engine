module Quby
  module Charting
    class PlottedScore < Struct.new(:key, :label, :plotted_key)
      def initialize(key, options = {})
        @key         = key
        @label       = options[:label]
        @plotted_key = options.fetch(:plotted_key) { :value }
      end
    end
  end
end

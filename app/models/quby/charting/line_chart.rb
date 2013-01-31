require 'virtus'

module Quby
  module Charting
    class LineChart
      include Virtus

      attribute :key,                        Symbol
      attribute :title,                      String
      attribute :y_label,                    String
      attribute :y_range,                    Range
      attribute :y_stepsize,                 Float
      attribute :tonality,                   Symbol
      attribute :baseline,                   Float
      attribute :clinically_relevant_change, Float

      def initialize(key, options = {})
        self.key = key
        super(options)
      end
    end
  end
end

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
      attribute :tonality,                   Symbol, default: :lower_is_better
      attribute :baseline,                   Float
      attribute :clinically_relevant_change, Float
      attribute :scores,                     Array[::Quby::Score]

      def initialize(key, options = {})
        self.key = key
        super(options)
      end

      def tonality=(value)
        raise "Invalid tonality: #{value}" unless [:higher_is_better, :lower_is_better].include?(value)
        super
      end
    end
  end
end

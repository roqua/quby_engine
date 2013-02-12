require 'virtus'

module Quby
  module Charting
    class Chart
      include Virtus

      attribute :key,                        Symbol
      attribute :title,                      String
      attribute :scores,                     Array[::Quby::Score]

      def initialize(key, options = {})
        self.key = key
        super(options)
      end

      def type
        self.class.name.to_s.demodulize.underscore
      end
    end
  end
end

require_relative 'chart'

module Quby
  module Compiler
    module Entities
      module Charting
        class OverviewChart < Chart
          # @return Symbol
          attr_accessor :subscore

          # @return Integer
          attr_accessor :y_max

          def initialize(key, subscore: nil, y_max: nil, **kwargs)
            super(key, **kwargs)
            self.subscore = subscore
            self.y_max = y_max
          end
        end
      end
    end
  end
end

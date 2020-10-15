# frozen_string_literal: true

require 'quby/compiler/entities/charting/chart'

module Quby
  module Compiler
    module Entities
      module Charting
        class RadarChart < Chart
          # @return [Array]
          attr_accessor :plotlines

          def initialize(key, plotlines: nil, **kwargs)
            super(key, **kwargs)
            self.plotlines = plotlines || []
          end
        end
      end
    end
  end
end

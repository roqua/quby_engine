# frozen_string_literal: true

require 'quby/questionnaires/entities/charting/chart'

module Quby
  module Questionnaires
    module Entities
      module Charting
        class BarChart < Chart
          attr_accessor :plotlines

          def initialize(key, plotlines: nil, **kwargs)
            super(key, **kwargs)
            self.plotlines = plotlines || []
          end

          #attribute :plotlines,                 Array
        end
      end
    end
  end
end

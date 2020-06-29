require_relative 'chart'

module Quby
  module Questionnaires
    module Entities
      module Charting
        class OverviewChart < Chart
          # @return Symbol
          attr_accessor :subscore

          # @return Integer
          attr_accessor :y_max

          def initialize
          end
        end
      end
    end
  end
end

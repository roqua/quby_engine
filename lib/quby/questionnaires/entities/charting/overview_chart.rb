require_relative 'chart'

module Quby
  module Questionnaires
    module Entities
      module Charting
        class OverviewChart < Chart
          attribute? :subscore, Types::Symbol
          attribute? :y_max, Types::Integer
        end
      end
    end
  end
end

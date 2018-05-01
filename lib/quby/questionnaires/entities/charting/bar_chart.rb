require 'quby/questionnaires/entities/charting/chart'

module Quby
  module Questionnaires
    module Entities
      module Charting
        class BarChart < Chart
          attribute :plotlines,                 Array
        end
      end
    end
  end
end

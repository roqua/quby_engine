# frozen_string_literal: true

require 'quby/questionnaires/entities/charting/chart'

module Quby
  module Questionnaires
    module Entities
      module Charting
        class RadarChart < Chart
          attribute :plotlines,                 Array
        end
      end
    end
  end
end

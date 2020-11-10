# frozen_string_literal: true

require 'quby/questionnaires/entities/charting/chart'

module Quby
  module Questionnaires
    module Entities
      module Charting
        class BarChart < Chart
          attribute? :plotlines, Types::Array.of(Types::Plotline).default { [] }
        end
      end
    end
  end
end

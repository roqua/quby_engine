# frozen_string_literal: true

require 'quby/questionnaires/entities/charting/chart'

module Quby
  module Questionnaires
    module Entities
      module Charting
        class BarChart < Chart
          def initialize(key, **kwargs)
            super(key, **kwargs)
          end
        end
      end
    end
  end
end

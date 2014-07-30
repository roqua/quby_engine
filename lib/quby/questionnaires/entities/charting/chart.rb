require 'virtus'

module Quby
  module Questionnaires
    module Entities
      module Charting
        class Chart
          include Virtus.model

          attribute :key,                        Symbol
          attribute :title,                      String
          attribute :plottables,                 Array
          attribute :chart_type,                 Symbol
          attribute :y_range,       Range
          attribute :tick_interval, Float

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
  end
end

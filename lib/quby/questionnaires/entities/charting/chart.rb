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
          # if categories are defined, plottable values should correspond to values from this array
          # and the graph will  be plotted with matching y axis categories
          attribute :y_categories,               Array
          attribute :chart_type,                 Symbol
          attribute :y_range,                    Range, default: :default_y_range, lazy: true
          attribute :tick_interval,              Float

          def initialize(key, options = {})
            self.key = key
            super(options)
          end

          def type
            self.class.name.to_s.demodulize.underscore
          end

          def default_y_range
            # when there are y_categories, the y_range should match the
            # number of categories (validated in chart_builder#validate!)
            (0..(y_categories.count - 1)) if y_categories.present?
            # otherwise, nil is allowed as a y_range
          end
        end
      end
    end
  end
end

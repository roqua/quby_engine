# frozen_string_literal: true

module Quby
  module Questionnaires
    module Entities
      module Charting
        class Plottable  < Struct.new(:key, :label, :plotted_key, :questionnaire_key, :global)
          def initialize(key, options = {})
            key         = key
            label       = options[:label]
            plotted_key = options.fetch(:plotted_key) { :value }
            global      = options[:global]
            questionnaire_key = options[:questionnaire_key]
            super(key, label, plotted_key, questionnaire_key, global)
          end
        end
      end
    end
  end
end

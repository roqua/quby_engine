module Quby
  module Questionnaires
    module Entities
      class ScoreCalculation
        attr_accessor :key
        attr_accessor :label
        attr_accessor :sbg_key
        attr_accessor :options
        attr_accessor :calculation

        def initialize(key, options, &block)
          @key = key
          @label = options[:label]
          @sbg_key = options[:sbg_key]
          @options = options
          @calculation = block
        end

        def score
          @options[:score]
        end

        def completion
          @options[:completion]
        end

        def action
          @options[:action]
        end
      end
    end
  end
end

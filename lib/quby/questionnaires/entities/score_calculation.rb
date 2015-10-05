module Quby
  module Questionnaires
    module Entities
      class ScoreCalculation
        attr_accessor :key
        attr_accessor :label
        attr_accessor :options
        attr_accessor :calculation
        attr_accessor :short_key

        def initialize(key, options, &block)
          @key = key
          @short_key = options[:short_key]
          @label = options[:label]
          @options = options
          @calculation = block
        end

        def short_key
          @short_key || @key[0..7]
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

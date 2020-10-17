# frozen_string_literal: true

module Quby
  module Compiler
    module Entities
      class ScoreCalculation
        attr_accessor :key, :label, :sbg_key, :options, :calculation

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
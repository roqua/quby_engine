# frozen_string_literal: true

module Quby
  module Questionnaires
    module Entities
      class ScoreCalculation
        attr_accessor :key, :label, :sbg_key, :options, :calculation

        def initialize(key, options, &block)
          @key = key
          @label = options[:label]
          @sbg_key = options[:sbg_key]
          @options = options[:options] || options # TODO remove `|| options`
          @calculation = block || options[:sourcecode]
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

module Quby
  class ScoreCalculation
    attr_accessor :key
    attr_accessor :label
    attr_accessor :options
    attr_accessor :calculation

    def initialize(key, options, &block)
      @key = key
      @label = options[:label]
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

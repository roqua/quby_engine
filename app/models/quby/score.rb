module Quby
  class Score
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
  end
end

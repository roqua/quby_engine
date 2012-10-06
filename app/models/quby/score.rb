module Quby
  class Score
    attr_accessor :key
    attr_accessor :label
    attr_accessor :calculation

    def initialize(key, options, &block)
      @key = key
      @label = options[:label]
      @calculation = block
    end
  end
end

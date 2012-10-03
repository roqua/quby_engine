module Quby
  class Score
    attr_accessor :key
    attr_accessor :calculation

    def initialize(key, options, &block)
      @key = key
      @calculation = block
    end
  end
end

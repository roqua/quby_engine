module Quby
  class LineChart
    attr_accessor :key
    attr_accessor :title

    def initialize(key, options = {})
      @key = key
    end
  end
end

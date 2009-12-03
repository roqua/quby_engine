class Score
  attr_accessor :key
  attr_accessor :scorer

  def initialize(key, options, &block)
    @key = key
    @scorer = block
  end
end

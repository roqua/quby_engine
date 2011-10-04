module QuestionnaireDsl
  class ScoreBuilder
    attr_reader :key
    attr_reader :scorer

    def initialize(key, options = {}, &block)
      @score = Score.new(key, options, &block)
    end

    def build
      @score
    end
  end
end

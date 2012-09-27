module Quby
  module QuestionnaireDsl
    class ScoreBuilder
      attr_reader :key
      attr_reader :calculation

      def initialize(key, options = {}, &block)
        @score = ::Quby::Score.new(key, options, &block)
      end

      def build
        @score
      end
    end
  end
end

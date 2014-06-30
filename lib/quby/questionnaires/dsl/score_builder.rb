require 'quby/questionnaires/entities'

module Quby
  module Questionnaires
    module DSL
      class ScoreBuilder
        attr_reader :key
        attr_reader :calculation

        def initialize(key, options = {}, &block)
          @score = Entities::ScoreCalculation.new(key, options, &block)
        end

        def build
          @score
        end
      end
    end
  end
end

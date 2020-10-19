# frozen_string_literal: true

module Quby
  module Questionnaires
    module Entities
      # method_source gem gives us the full score source code including the initial `score() do` DSL call.
      # This module helps strip off that outer DSL call.
      module StripOuterScoreCall
        def self.score(*args, &block)
          block
        end

        def self.variable(*args, &block)
          block
        end

        def self.attention(*args, &block)
          block
        end

        def self.alert(*args, &block)
          block
        end

        def completion(*args, &block)
          block
        end
      end

      class ScoreCalculation
        attr_accessor :key, :label, :sbg_key, :options

        def initialize(key, options, &block)
          @key = key
          @label = options[:label]
          @sbg_key = options[:sbg_key]
          @options = options[:options] || options # TODO remove `|| options`
          @sourcecode = options[:sourcecode]
          @block = block
        end

        def calculation
          if @block
            @block
          else
            StripOuterScoreCall.instance_eval(@sourcecode)
          end
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

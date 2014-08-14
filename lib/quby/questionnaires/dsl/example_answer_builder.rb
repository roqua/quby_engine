require 'quby/questionnaires/entities'

module Quby
  module Questionnaires
    module DSL
      class ExampleAnswerBuilder
        def initialize(label)
          @label = label
        end

        def values(hsh = {})
          @values = hsh
        end

        def outcome(hsh = {})
          @outcome = hsh
        end

        def build(&block)
          instance_eval(&block)

          {
            label: @label,
            values: @values,
            outcome: @outcome
          }
        end
      end
    end
  end
end

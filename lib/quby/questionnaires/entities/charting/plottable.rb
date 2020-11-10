# frozen_string_literal: true

module Quby
  module Questionnaires
    module Entities
      module Charting
        class Plottable  < Dry::Struct
          transform_keys(&:to_sym)

          attribute :key, Types::Coercible::Symbol
          attribute? :label, Types::String
          attribute? :plotted_key, Types::Coercible::Symbol.default(:value)
          attribute? :questionnaire_key, Types::String
          attribute? :global, Types::Bool.optional
        end
      end
    end
  end
end

# frozen_string_literal: true
require 'dry-struct'

module Quby
  module Questionnaires
    module Entities
      class Textvar < Dry::Struct
        transform_keys(&:to_sym)

        attribute :key, Types::Coercible::Symbol
        attribute :description, Types::String.optional
        attribute? :default, Types::String.optional
        attribute? :depends_on_flag, Types::Coercible::Symbol.optional

        def default
          attributes[:default] || "{{#{key}}}"
        end

        def to_codebook(_options = {})
          output = []
          output << "#{key} Textvariabele"
          output << description
          output.join("\n")
        end
      end
    end
  end
end

require 'dry-types'

module Quby
  module Types
    include Dry.Types()

    Range = Types::Nominal(::Range).constructor do |value|
      if value.is_a?(::Range)
        value
      elsif value.is_a?(::Hash)
        value = value.stringify_keys
        ::Range.new(value.fetch("begin"), value.fetch("end"), value.fetch("exclude_end"))
      end
    end

    Number = Integer | Float
    Color = Symbol | String
    Gender = Coercible::Symbol # for now

    Plotline = Hash.schema(color: Color, value: Number, width: Integer, zIndex: Integer).with_key_transform(&:to_sym)
    Plotband = Types::Hash.schema(color: Types::Color, from: Types::Number, to: Types::Number ).with_key_transform(&:to_sym)

    module Strict
      include Dry.Types()

      Range = Instance(::Range).constrained(type: ::Range)
    end
  end
end
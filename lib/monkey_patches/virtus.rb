require 'virtus'
require 'virtus/version'

if Virtus::VERSION > '1.0' && Virtus::VERSION <= '1.0.2'
  module Virtus
    class Attribute
      class Builder
        def self.determine_type(klass, default = nil)
          type = Attribute.determine_type(klass)

          if klass.is_a?(Class)
            type ||=
              if klass < Axiom::Types::Type
                determine_type(klass.primitive)
              elsif EmbeddedValue.handles?(klass)
                EmbeddedValue
              elsif klass < Enumerable && !(klass <= Range)
                Collection
              end
          end

          type || default
        end
      end
    end
  end
end

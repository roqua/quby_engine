# frozen_string_literal: true

require 'quby/compiler/dsl/helpers'
require 'quby/compiler/dsl/calls_custom_methods'

module Quby
  module Compiler
    module DSL
      class Base
        include Helpers

        def self.build(*args, &block)
          builder = new(*args)
          builder.instance_eval(&block) if block
          builder.build
        end
      end
    end
  end
end

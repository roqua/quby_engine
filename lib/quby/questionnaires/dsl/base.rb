require 'quby/questionnaires/dsl/helpers'
require 'quby/questionnaires/dsl/calls_custom_methods'

module Quby
  module Questionnaires
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

module Quby
  module Questionnaires
    module DSL
      class Base
        def self.build(*args, &block)
          builder = new(*args)
          builder.instance_eval(&block) if block
          builder.build
        end
      end
    end
  end
end

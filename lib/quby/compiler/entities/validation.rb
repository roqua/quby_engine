module Quby
  module Compiler
    module Entities
      class Validation
        attr_reader :config

        def initialize(config)
          @config = config
        end

        def type
          config[:type]
        end
      end
    end
  end
end

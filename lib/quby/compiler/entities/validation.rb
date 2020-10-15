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

        def as_json
          case type
          when :regexp
            valc = config.clone
            valc[:matcher] = valc[:matcher].source.to_s

            # Replace single backslashes with two backslashes
            valc[:matcher].gsub!("\\", "\\\\")

            valc
          else
            config
          end.deep_transform_keys{ |key| key.to_s.camelize(:lower) }
        end
      end
    end
  end
end

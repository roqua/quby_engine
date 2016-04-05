module Quby
  module Questionnaires
    module Entities
      class Textvar < Struct.new(:key, :description, :default)
        def initialize(key:, description:, default: nil)
          default = "{{#{key}}}" unless default
          super(key, description, default)
        end
      end
    end
  end
end

module Quby
  module Questionnaires
    module Entities
      class Textvar < Struct.new(:key, :description, :default)
        # rubocop:disable ParameterLists
        def initialize(key:, description:, default: nil)
          default = "{{#{key}}}" unless default
          super(key, description, default)
        end
        # rubocop:enable ParameterLists

        def to_codebook(_options = {})
          output = []
          output << "#{key} Text variabele"
          output << description
          output.join("\n")
        end
      end
    end
  end
end

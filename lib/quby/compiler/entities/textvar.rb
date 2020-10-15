# frozen_string_literal: true

module Quby
  module Compiler
    module Entities
      class Textvar < Struct.new(:key, :description, :default, :depends_on_flag)
        # rubocop:disable ParameterLists
        def initialize(key:, description:, default: nil, depends_on_flag: nil)
          default = "{{#{key}}}" unless default
          super(key, description, default, depends_on_flag)
        end
        # rubocop:enable ParameterLists

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

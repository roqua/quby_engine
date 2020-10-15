# frozen_string_literal: true

require 'active_model'

module Quby
  module Compiler
    module Entities
      class Item
        include ActiveModel::Validations
        include ActiveSupport::Callbacks
        define_callbacks :after_dsl_enhance

        attr_accessor :presentation
        attr_accessor :switch_cycle

        # Raw content may contain a raw HTML replacement for this item
        attr_accessor :raw_content

        def initialize(options = {})
          @raw_content = options[:raw_content]
          @switch_cycle = options[:switch_cycle] || false
        end

        def presentation
          @presentation || "vertical"
        end

        def as_json(options = {})
          {
            class: self.class.to_s
          }
        end

        def to_codebook(questionnaire, options = {})
          ""
        end
      end
    end
  end
end

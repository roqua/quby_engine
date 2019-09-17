# frozen_string_literal: true

require 'active_model'
require 'quby/questionnaires/services/definition_validator'

module Quby
  module Questionnaires
    module Entities
      class Definition
        extend  ActiveModel::Naming
        include ActiveModel::Validations

        attr_accessor :key, :sourcecode, :timestamp

        def initialize(key:, sourcecode: "", timestamp: nil)
          @key = key
          @sourcecode = sourcecode
          @timestamp = timestamp
        end

        validates_with Services::DefinitionValidator
      end
    end
  end
end

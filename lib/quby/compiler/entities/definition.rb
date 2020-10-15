# frozen_string_literal: true

require 'active_model'
require 'quby/compiler/services/definition_validator'

module Quby
  module Compiler
    module Entities
      class Definition
        extend  ActiveModel::Naming
        include ActiveModel::Validations

        attr_accessor :key, :sourcecode, :timestamp, :path

        def initialize(key:, path:, sourcecode: "", timestamp: nil)
          @path = path
          @key = key
          @sourcecode = sourcecode
          @timestamp = timestamp
        end

        validates_with Services::DefinitionValidator
      end
    end
  end
end

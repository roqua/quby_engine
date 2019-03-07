# frozen_string_literal: true

require 'active_model'
require 'dry-types'
require 'dry-struct'
require 'quby/questionnaires/services/definition_validator'

module Quby
  module Questionnaires
    module Entities
      class Definition < Dry::Struct::Value
        extend  ActiveModel::Naming
        include ActiveModel::Validations

        module Types
          include Dry::Types.module
        end

        attribute :key, Types::String
        attribute :sourcecode, Types::String
        attribute :timestamp, Types::Time.meta(omittable: true)

        validates_with Services::DefinitionValidator
      end
    end
  end
end

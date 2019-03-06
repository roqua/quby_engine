# frozen_string_literal: true

require 'active_model'
require 'active_model_attributes'
require 'quby/questionnaires/services/definition_validator'

module Quby
  module Questionnaires
    module Entities
      class Definition
        include ActiveModel::Model
        include ActiveModelAttributes

        attribute :key, :string
        attribute :sourcecode, :string
        attribute :timestamp, :time

        validates_with Services::DefinitionValidator
      end
    end
  end
end

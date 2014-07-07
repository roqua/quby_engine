require 'active_model'
require 'quby/questionnaires/services/definition_validator'

module Quby
  module Questionnaires
    module Entities
      class Definition
        include Virtus.value_object
        extend  ActiveModel::Naming
        include ActiveModel::Validations

        values do
          attribute :key, String
          attribute :sourcecode, String
          attribute :timestamp, Time
        end

        validates_with Services::DefinitionValidator
      end
    end
  end
end

require 'active_model'

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
      end
    end
  end
end

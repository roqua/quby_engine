module Quby
  module Questionnaires
    module Entities
      class Textvar < Struct.new(:key, :description, :default)
        # rubocop:disable ParameterLists
        def initialize(key:, description:, default: nil)
          super(key, description, default)
        end
        # rubocop:enable ParameterLists
      end
    end
  end
end

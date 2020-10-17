# frozen_string_literal: true

require 'active_model'

module Quby
  module Questionnaires
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
      end
    end
  end
end

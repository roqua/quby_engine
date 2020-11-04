# frozen_string_literal: true

require 'active_model'

module Quby
  module Questionnaires
    module Entities
      class Definition
        extend  ActiveModel::Naming
        include ActiveModel::Validations

        attr_accessor :key, :sourcecode, :json, :timestamp, :path

        def initialize(key:, path:, sourcecode: "", json: nil, timestamp: nil)
          @path = path
          @key = key
          @sourcecode = sourcecode
          @json = json
          @timestamp = timestamp
        end
      end
    end
  end
end

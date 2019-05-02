# frozen_string_literal: true

require 'active_support/all'

module Quby
  module Answers
    module Entities
      class Respondent
        attr_accessor :type

        def initialize(attributes = {})
          attributes = attributes.with_indifferent_access
          @type = attributes[:respondent_type]
        end
      end
    end
  end
end

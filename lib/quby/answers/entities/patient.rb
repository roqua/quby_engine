require 'active_support/all'

module Quby
  module Answers
    module Entities
      class Patient
        attr_accessor :gender, :birthyear

        def initialize(attributes = {})
          attributes = attributes.with_indifferent_access
          @gender    = attributes[:gender] || :unknown
          @birthyear = attributes[:birthyear]
        end

        # returns the age at the given timestamp, as an integer
        # NB: if you make this a float, this breaks various questionnaire score calculations that do the following:
        # `if (8..12).cover?(age) ... elsif (13..15).cover?(age)` etc.
        def age_at(timestamp)
          return nil unless @birthyear and timestamp
          ((timestamp - Time.gm(@birthyear, 1, 1)) / 1.year).floor
        end
      end
    end
  end
end

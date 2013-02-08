require 'active_support/all'
module Quby
  class Patient
    attr_accessor :gender, :birthyear

    def initialize(attributes = {})
      attributes = attributes.with_indifferent_access
      @gender    = attributes[:gender] || :unknown
      @birthyear = attributes[:birthyear]
    end

    def age_at(timestamp)
      return nil unless @birthyear and timestamp
      ((timestamp - Time.gm(@birthyear, 1, 1)) / 1.year).floor
    end
  end
end

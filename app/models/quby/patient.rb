require 'active_support/all'
module Quby
  class Patient
    attr_accessor :gender, :age_at_answer_creation, :answer_created_at

    def initialize(attributes = {})
      @gender    = attributes[:gender] || :unknown
      @birthyear = attributes[:birthyear]
    end

    def age
      ((Time.now - Time.gm(@birthyear, 1, 1)) / 1.year).floor
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

module Quby::Questionnaires::Entities
  describe Panel do
    it "should be possible to make without options" do
      expect { Quby::Questionnaires::Entities::Panel.new }.to_not raise_error
    end
  end
end

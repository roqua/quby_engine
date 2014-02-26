require 'spec_helper'

module Quby
  describe Items::Panel do
    it "should be possible to make without options" do
      expect{ Quby::Items::Panel.new }.to_not raise_error
    end
  end
end

require 'spec_helper'

module Quby
  describe Items::Panel do
    it "should be possible to make without options" do
      lambda { Items::Panel.new }.should_not raise_error
    end
  end
end

require 'spec_helper'

describe Items::Text do
  before(:each) do
    @some_string = "I'm a string"
  end

  it "should be creatable from a string" do
    lambda { Items::Text.new(@some_string) }.should_not raise_error
  end

  describe "#to_s" do
    it "should return the string the Text was initialized with" do
      t = Items::Text.new(@some_string)
      t.to_s.should == @some_string
    end
  end
end

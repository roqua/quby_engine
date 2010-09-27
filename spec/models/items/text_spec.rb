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
      text = Items::Text.new(@some_string)
      text.to_s.should == @some_string
    end
  end

  it "should be valid for any hash" do
    text = Items::Text.new(@some_string)
    text.validate_answer({}).should be_true
  end
end

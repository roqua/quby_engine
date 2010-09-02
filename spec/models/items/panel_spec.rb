require 'spec_helper'

describe Items::Panel do
  before(:each) do
    @q = Questionnaire.new
  end

  it "should be possible to make without options" do
    lambda { Items::Panel.new }.should_not raise_error
  end
end

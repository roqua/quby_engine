require 'spec_helper'

describe Items::Panel do
  before(:each) do
    @q = Questionnaire.new
  end

  it "should be possible to make without options" do
    lambda { Items::Panel.new }.should_not raise_error
  end

  describe "validation" do
    it "should be valid for an empty panel" do
      Items::Panel.new.validate_answer({}).should be_true
    end

    it "should be valid for a valid answer" do
      @panel = Items::Panel.new
      @panel.items = [Items::Question.new(:name, :type => :string, :required => true)]
      @panel.validate_answer({:name => "John Doe"}).should be_true
    end

    it "should not be valid for an invalid answer" do
      @panel = Items::Panel.new
      @panel.items = [Items::Question.new(:name, :type => :string, :required => true)]
      @panel.validate_answer({:date => "Today"}).should_not be_true
    end
  end
end

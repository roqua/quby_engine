require 'spec_helper'

module Quby::Questionnaires::Entities
  describe Text do
    before(:all) do
      @some_string = "I'm a string"
      @markdown_result = "<p>I&#8217;m a string</p>"
    end

    it "should be creatable from a string" do
      expect { Quby::Questionnaires::Entities::Text.new(@some_string) }.to_not raise_error
    end

    describe "#to_s" do
      it "should return the string the Text was initialized with" do
        text = Quby::Questionnaires::Entities::Text.new(@some_string)
        text.to_s.should == @markdown_result
      end
    end

    it "should be valid for any hash" do
      text = Quby::Questionnaires::Entities::Text.new(@some_string)
      text.validate_answer({}).should be_truthy
    end
  end
end

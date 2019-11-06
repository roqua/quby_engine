# frozen_string_literal: true

require 'spec_helper'

module Quby::Questionnaires::Entities
  describe Text do
    before(:all) do
      @some_string = "I'm a string"
      @markdown_result = "<p>I&rsquo;m a string</p>"
    end

    it "should be creatable from a string" do
      expect { Quby::Questionnaires::Entities::Text.new(@some_string) }.to_not raise_error
    end

    describe "#to_s" do
      it "should return the string the Text was initialized with" do
        text = Quby::Questionnaires::Entities::Text.new(@some_string)
        expect(text.to_s).to eq @markdown_result
      end
    end

    it "should be valid for any hash" do
      text = Quby::Questionnaires::Entities::Text.new(@some_string)
      expect(text.validate_answer({})).to be_truthy
    end
  end
end

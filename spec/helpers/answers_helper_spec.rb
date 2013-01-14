require 'spec_helper'

describe Quby::AnswersHelper do

  describe ".marukufix" do

    it "returns an empty string if it gets an empty title string" do
      marukufix("", "v_1").should == ""
    end
    it 'wraps the title in a div structure' do
      marukufix("test", "v_1").should == " <div class='main'><label for='v_1'>test</label> </div>"
    end
    it 'transforms maruku syntax into html' do
      marukufix("*test*", "v_1").include?("<em>test</em>").should be_true
    end
    it "splits off the number in front of the title into a separate qnumber div" do
      marukufix("13. test", "v_1").include?("<div class='qnumber'>13.</div>").should be_true
    end
    it "adds the title insert at the end of the main div" do
      marukufix("test", "v_1", "<div>insert</div>").include?("<div>insert</div>").should be_true
    end
  end

  describe ".table_marukufix" do
    it 'wraps the title in a td structure' do
      table_marukufix("test", "v_1", 1).should == " <td class='main'><label for='v_1'>test</label></td>"
    end
    it 'transforms maruku syntax into html' do
      table_marukufix("*test*", "v_1", 1).include?("<em>test</em>").should be_true
    end
    it "splits off the number in front of the title into a separate qnumber div" do
      table_marukufix("13. test", "v_1", 1).include?("<div class='qnumber'>13.</div>").should be_true
    end
    it "adds the title insert at the end of the main div" do
      table_marukufix("test", "v_1", 1, "<div>insert</div>").include?("<div>insert</div>").should be_true
    end
  end

end
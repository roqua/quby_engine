require 'spec_helper'

module Quby
  describe AnswersHelper do

    let(:helper) do
      helper = ActionView::Base.new
      helper.class_eval {include Quby::AnswersHelper}
      helper
    end

    describe ".marukufix" do
      it 'wraps the title in a div structure' do
        helper.marukufix("test", "v_1").should == " <div class='main'><label for='v_1'>test</label> </div>"
      end
      it 'transforms maruku syntax into html' do
        helper.marukufix("*test*", "v_1").include?("<em>test</em>").should be_true
      end
      it "splits off the number in front of the title into a separate qnumber div" do
        helper.marukufix("13. test", "v_1").include?("<div class='qnumber'>13.</div>").should be_true
      end
      it "adds the title insert at the end of the main div" do
        helper.marukufix("test", "v_1", "<div>insert</div>").include?("<div>insert</div>").should be_true
      end
    end

    describe ".table_marukufix" do
      it 'wraps the title in a td structure' do
        helper.table_marukufix("test", "v_1", 1).should == " <td class='main'><label for='v_1'>test</label></td>"
      end
      it 'transforms maruku syntax into html' do
        helper.table_marukufix("*test*", "v_1", 1).include?("<em>test</em>").should be_true
      end
      it "splits off the number in front of the title into a separate qnumber div" do
        helper.table_marukufix("13. test", "v_1", 1).include?("<div class='qnumber'>13.</div>").should be_true
      end
      it "adds the title insert at the end of the main div" do
        helper.table_marukufix("test", "v_1", 1, "<div>insert</div>").include?("<div>insert</div>").should be_true
      end
    end
  end
end
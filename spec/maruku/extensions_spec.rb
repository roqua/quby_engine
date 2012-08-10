require 'spec_helper'
require 'extensions/maruku_extensions'

class Maruku

  describe ".setTextVar" do
    it 'stores the value in varname' do
      Maruku.setTextVar("testkey", "value")
      Maruku.send(:text_vars)["testkey"].should == "value"
    end
    it "stores nil if the value is blank" do
      Maruku.setTextVar("testkey", "")
      Maruku.send(:text_vars)["testkey"].should == nil
    end
  end
  describe ".getTextVar" do
    it 'gets the stored value in varname' do
      Maruku.setTextVar("testkey", "value")
      Maruku.getTextVar("testkey").should == "value"
    end
  end

  describe "link tag extenstion ~~url~~body~~" do
    it "converts ~~url~~body~~ into a modal frame link" do
      Maruku.new("~~http://google.com~~google~~").to_html.should == "<p><a href='#' onclick='modalFrame(\"http://google.com\");'>google</a></p>"
    end
  end

  describe "text variable extenstion {{text_var}}" do
    it "converts {{test}} into a text variable span" do
      Maruku.new("{{test}}").to_html.should == "<p><span class='text_var' text_var='test'>{{test}}</span></p>"
    end

    it "fills in the text variable if it is known" do
      Maruku.setTextVar("testkey", "value")
      Maruku.new("{{testkey}}").to_html.should == "<p><span class='text_var' text_var='testkey'>value</span></p>"
    end

    it "properly converts 2 text tags next to each other" do
      Maruku.new("{{test}} {{test2}}").to_html.should == "<p><span class='text_var' text_var='test'>{{test}}</span> <span class='text_var' text_var='test2'>{{test2}}</span></p>"
    end
  end
end

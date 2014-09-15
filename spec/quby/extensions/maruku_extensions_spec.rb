require 'spec_helper'

class Maruku
  # rubocop:disable LineLength

  describe "link tag extenstion ~~url~~body~~" do
    it "converts ~~url~~body~~ into a modal frame link" do
      Maruku.new("~~http://google.com~~google~~").to_html.strip.should == "<p><a href='#' onclick='modalFrame(\"http://google.com\");'>google</a></p>"
    end
  end

  describe "text variable extenstion {{text_var}}" do
    it "converts {{test}} into a text variable span" do
      Maruku.new("{{test}}").to_html.strip.should == "<p><span class='text_var' text_var='test'>{test}</span></p>"
    end

    it "properly converts 2 text tags next to each other" do
      Maruku.new("{{test}} {{test2}}").to_html.strip.should == "<p><span class='text_var' text_var='test'>{test}</span> <span class='text_var' text_var='test2'>{test2}</span></p>"
    end
  end

  describe "raises errors" do
    it 'raises on errorneus syntax' do
      expect { Maruku.new("*hoi") }.to raise_error(MaRuKu::Exception)
    end
  end
end

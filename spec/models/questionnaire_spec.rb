require 'spec_helper'

describe Questionnaire do
  before(:each) do
    @q = Questionnaire.new
  end

  it "should be possible to create a new questionnaire with a key"
  it "should require a key to create"
  
  it "should support panels" do
    QuestionnaireDsl.enhance(@q, "panel {}")

    @q.panels.size.should == 1
    @q.panels[0].class.should == Items::Panel
  end
  
  it "should support questions" do
    QuestionnaireDsl.enhance(@q, "question(:myid, :title => 'Question 1') {}")

    @q.panels.size.should == 1
    @q.panels[0].items[0].class.should == Items::Question
  end
  
  it "should support text" do
    QuestionnaireDsl.enhance(@q, "text 'The quick brown fox jumps over the lazy dog.'")

    @q.panels.size.should == 1
    @q.panels[0].items[0].class.should == Items::Text
  end
end

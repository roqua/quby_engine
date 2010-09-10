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

  it "should return a flat list of items in the questionnaire" do
    questionnaire = <<-END
      question :q01i, :type => :radio do
        title "Foo"
        option :a01, :description => "Foo1" do
          question(:q01sub, :type => :string, :title => "Blaat") {}
        end
      end

      question :q02 do
        title "Bar"
      end
    END

    QuestionnaireDsl.enhance(@q, questionnaire)
    @q.questions.length.should == 3
  end

  it "should return a tree of items in the questionnaire" do
    questionnaire = <<-END
      question :q01i, :type => :radio do
        title "Foo"
        option :a01, :description => "Foo1" do
          question(:q01sub, :type => :string, :title => "Blaat") {}
        end
      end

      question :q02 do
        title "Bar"
      end
    END

    QuestionnaireDsl.enhance(@q, questionnaire)
    @q.questions_tree.should be_an Array
    
    pending "write more expectations"
  end

end

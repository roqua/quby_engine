require 'spec_helper'

module Quby
  describe Questionnaire do
    describe "persistence" do
      let(:key)           { 'test' }
      let(:definition)    { "title 'My Test'" }
      let(:questionnaire) { Questionnaire.new(key, definition) }

      before do
        @file = Tempfile.new("questionnaire_spec")
        @file.close
        questionnaire.stub(:path) { @file.path }
      end

      after do
        @file.unlink
      end

      it "should save to disk" do
        questionnaire.save
        File.open(@file.path, 'r').read.should == definition
      end

      it "should not save Windows linebreaks" do
        questionnaire.definition = "title 'My Test'\r\nshort_description 'Test questionnaire'"
        questionnaire.save
        File.open(@file.path, 'r').read.should == "title 'My Test'\nshort_description 'Test questionnaire'"
      end
    end

    describe "validations" do
      it "should be valid for a valid questionnaire" do
        Questionnaire.new("test", "title \"hallo wereld\"").should be_valid
      end
      
      it "should require a key" do
        Questionnaire.new(nil, "title \"hallo wereld\"").should_not be_valid
      end
    end
    
    describe '#scores' do
      Questionnaire.new("test").scores.should == []
    end
    
    describe '#to_codebook' do
      let(:key)           { 'test' }
      let(:definition)    { "title 'My Test' \n question(:v_1, :type => :radio) { option :a1, :value => 0; option :a2, :value => 1}" }
      let(:questionnaire) { Questionnaire.new(key, definition) }

      it "should be able to generate a codebook" do
        questionnaire.to_codebook.should be
      end
    end

    #it "should support panels" do
      #@q = quest("panel {}")

      #@q.panels.size.should == 1
      #@q.panels[0].class.should == Items::Panel
    #end
    
    #it "should support questions" do
      #@q = quest("question(:myid, :title => 'Question 1') {}")

      #@q.panels.size.should == 1
      #@q.panels[0].items[0].class.should == Items::Question
    #end
    
    #it "should support text" do
      #@q = quest("text 'The quick brown fox jumps over the lazy dog.'")

      #@q.panels.size.should == 1
      #@q.panels[0].items[0].class.should == Items::Text
    #end

    #it "should return a flat list of items in the questionnaire" do
      #questionnaire = <<-END
        #question :q01i, :type => :radio do
          #title "Foo"
          #option :a01, :description => "Foo1" do
            #question(:q01sub, :type => :string, :title => "Blaat") {}
          #end
        #end

        #question :q02 do
          #title "Bar"
        #end
      #END

      #@q = quest(questionnaire)
      #@q.questions.length.should == 3
    #end

    #it "should return a tree of items in the questionnaire" do
      #questionnaire = <<-END
        #question :q01i, :type => :radio do
          #title "Foo"
          #option :a01, :description => "Foo1" do
            #question(:q01sub, :type => :string, :title => "Blaat") {}
          #end
        #end

        #question :q02 do
          #title "Bar"
        #end
      #END

      #@q = quest(questionnaire)
      #@q.questions_tree.should be_an Array
      
      #pending "write more expectations"
    #end
    
    #it "should not accept duplicate question keys" do
      #questionnaire = <<-END
        #question :q01, :type => :radio 

        #question :q01 
      #END

      #quest(questionnaire).send(:validate_definition_syntax).should be_false
    #end
    
    #it "should not accept checkbox option keys that are the same as other question keys" do
      #questionnaire = <<-END
        #question :q01, :type => :radio 

        #question :q02, :type => :checkbox do 
          #option :q03
          #option :a1
        #end 
        
        #question :q03, :type => :radio 
      #END

      #quest(questionnaire).send(:validate_definition_syntax).should be_false
    #end
    
    #context "with some answers" do
      #before(:each) do
        #questionnaire = <<-END
          #default_answer_value :q01 => "antwoord"
          #question :q01, :type => :string, :title => "Blaat" 
        #END

        #@q = quest(questionnaire)
        #unless @q.save
          ##pp @q.errors and raise "Error saving questionnaire"
        #end
        
        #@q.answers.create!(:questionnaire_id => @q.id)
        #@q.answers.create!(:questionnaire_id => @q.id)
        #@q.answers.create!(:questionnaire_id => @q.id)
      #end
      
      #it "should have some answers" do
        #@q.answers.count.should == 3
      #end
      
      #it "should destroy dependent answers when questionnaire is destroyed" do
        #id = @q.id
        #@q.destroy
        #Answer.where(:questionnaire_id => id).should be_empty
      #end
    #end
  end
end

require 'spec_helper'

module Quby
  describe Questionnaire do
    before do
      @temp_dir = Dir.mktmpdir
      Quby.questionnaires_path = @temp_dir
    end

    after do
      FileUtils.remove_entry_secure @temp_dir
    end

    let(:key)           { 'test' }
    let(:definition)    { "title 'My Test'" }
    let(:questionnaire) { Questionnaire.new(key, definition) }

    describe "persistence" do

      it "should save to disk" do
        questionnaire.save

        Questionnaire.find_by_key(key).definition.should == definition
      end

      it "should not save Windows linebreaks" do
        questionnaire.definition = "title 'My Test'\r\nshort_description 'Test questionnaire'"
        questionnaire.save.should be

        #FakeFS does not implement ctime yet
        File.stub(:ctime => Time.now+10.minutes)

        Questionnaire.find_by_key(key).definition.should == "title 'My Test'\nshort_description 'Test questionnaire'"
      end
    end

    describe ".all" do
      it "marks questionnaires as persisted" do
        questionnaire.save

        quest = Quby::Questionnaire.all.first
        quest.persisted?.should be_true
      end
    end

    describe ".find_by_key" do
      it "marks a questionnaire as persisted" do

        questionnaire.save

        quest = Quby::Questionnaire.find_by_key 'test'
        quest.persisted?.should be_true
      end
    end

    describe "validations" do
      it "should be valid for a valid questionnaire" do
        Questionnaire.new("test", "title \"hallo wereld\"").should be_valid
      end

      it "should require a key" do
        Questionnaire.new(nil, "title \"hallo wereld\"").should_not be_valid
      end

      it "rejects a key when a questionnaire with this key already exists" do
        Quby::Questionnaire.stub(:exists? => true)
        Questionnaire.new("k_s_4", "title \"hallo wereld\"").should_not be_valid
      end

      describe "should no file with a given key exist" do
        before { Quby::Questionnaire.stub(:exists? => false) }

        it "requires that the key starts with a letter" do
          Questionnaire.new("4ks", "title \"hallo wereld\"").should_not be_valid
        end

        it "requires that the key contains no capitals" do
          Questionnaire.new("Ks", "title \"hallo wereld\"").should_not be_valid
        end

        it "requires that the key contains no more than 10 characters" do
          Questionnaire.new("verylongkey", "title \"hallo wereld\"").should_not be_valid
        end

        it "requires that the key contains no dashes" do
          Questionnaire.new("k-s", "title \"hallo wereld\"").should_not be_valid
        end

        it "requires that the key contains no whitespace" do
          Questionnaire.new("k s", "title \"hallo wereld\"").should_not be_valid
        end

        it "accepts a key containing lower case letters, numbers and underscores that start with a letter" do
          Questionnaire.new("k_s_4", "title \"hallo wereld\"").should be_valid
        end
      end

      describe "should a file exist for this key" do
        before { Quby::Questionnaire.stub(:exists? => true) }

        it "accepts any key" do
          quest = Questionnaire.new("4 K-s", "title \"hallo wereld\"")
          quest.persisted = true
          quest.should be_valid
        end
      end
    end

    describe '#scores' do
      Questionnaire.new("test").scores.should == []
    end

    describe '#score_builders' do
      Questionnaire.new("test").score_builders.should == {}
    end

    describe '#push_score_builder' do
      let(:questionnaire) { Questionnaire.new("test") }

      it 'adds the score builder to the list of score builders' do
        builder = double("Quby::Score", :key => "c")
        questionnaire.push_score_builder builder
        questionnaire.score_builders['c'].should == builder
      end

      it 'preserves order of added score builders' do
        questionnaire.push_score_builder double("Quby::Score", :key => "c")
        questionnaire.push_score_builder double("Quby::Score", :key => "a")
        questionnaire.push_score_builder double("Quby::Score", :key => "d")
        questionnaire.score_builders.keys.should == ['c','a','d']
      end

      it 'overwrites the score builder if there already is a score builder known for this key' do
        questionnaire.push_score_builder stub(:key => "c")

        new_builder = stub(:key => "c")
        questionnaire.push_score_builder new_builder
        questionnaire.score_builders.shift.last.should == new_builder
      end
    end

    describe '#find_plottable' do
      it 'finds score builders' do
        score = stub(:key => 'a')
        questionnaire.push_score_builder score
        questionnaire.find_plottable('a').should == score
      end

      it 'finds questions by key with indifferent access' do
        question = stub(:key => 'a')
        questionnaire.question_hash['a'] = question
        questionnaire.find_plottable(:a).should == question
      end
    end

    describe '#key_in_use?' do
      let(:definition)    { "title 'My Test' \n question :v_1 \n score :score_1 \n variable :var_1" }
      let(:questionnaire) { Questionnaire.new("test", definition) }

      it "should check if key is used by a question" do
        questionnaire.key_in_use?(:v_1).should be_true
      end
      it "should check if key is used by a score" do
        questionnaire.key_in_use?(:score_1).should be_true
      end
      it "should check if key is used by a variable" do
        questionnaire.key_in_use?(:var_1).should be_true
      end
    end

    describe '#to_codebook' do
      let(:definition)    { "title 'My Test' \n question(:v_1, :type => :radio) { option :a1, :value => 0; option :a2, :value => 1}" }
      let(:questionnaire) { Questionnaire.new("test", definition) }
      let(:definition_html_unsafe)    { "title 'My Test' \n question(:v_1, :type => :radio, :title => ' < 20') { option :a1, :value => 0; option :a2, :value => 1}" }
      let(:questionnaire_html) { Questionnaire.new("test2", definition_html_unsafe) }

      it "should be able to generate a codebook" do
        questionnaire.to_codebook.should be
      end

      it "should not break off a codebook when encountering <" do
        questionnaire_html.to_codebook.should == "My Test\nDate unknown\n\ntest2_1 radio \n\" < 20\"\n0\t\"\"\n1\t\"\"\n"
      end
    end

    describe '#add_chart' do
      let(:charts)        { stub }
      let(:chart)         { stub(key: 'tot', scores: [mock("Score")]) }
      let(:questionnaire) { Questionnaire.new('test') }

      it 'adds charts' do
        questionnaire.stub(charts: charts)
        charts.should_receive(:add).with(chart)
        questionnaire.add_chart(chart)
      end
    end

    describe '#questions_of_type' do
      let(:definition)    { "text 'text thing' \n question :v_1, type: :radio \n question :v_2, type: :string" }
      let(:questionnaire) { Questionnaire.new(:questions_of_type_test, definition) }
      it 'returns questions of the given type' do
        questionnaire.questions_of_type(:string).count.should == 1
        questionnaire.questions_of_type(:string).first.type.should == :string
      end
    end

    describe '#leave_page_alert' do
      it 'returns a given string' do
        questionnaire = Questionnaire.new 'test'
        questionnaire.leave_page_alert = "ALERT"
        expect(questionnaire.leave_page_alert).to eq("ALERT")
      end

      it 'returns a default string' do
        questionnaire = Questionnaire.new 'test'
        expect(questionnaire.leave_page_alert).to eq("Als u de pagina verlaat worden uw antwoorden niet opgeslagen.")
      end

      it 'returns nil if leave page alerts are disabled' do
        Settings.stub(enable_leave_page_alert: false)
        questionnaire = Questionnaire.new 'test'
        expect(questionnaire.leave_page_alert).to be_nil
      end
    end
  end
end

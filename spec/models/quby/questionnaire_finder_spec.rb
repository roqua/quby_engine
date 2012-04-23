require 'fakefs/spec_helpers'
require_relative "../../../app/models/quby/questionnaire_finder"

module Quby
  describe QuestionnaireFinder do
    include FakeFS::SpecHelpers

    before { FileUtils.mkdir_p("/tmp") }

    let(:questionnaire_class) do
      Class.new do
        attr_reader :key, :definition
        attr_accessor :persisted

        def initialize(key, definition)
          @key = key
          @definition = definition
        end
      end
    end

    let(:questionnaire_finder) { QuestionnaireFinder.new("/tmp", questionnaire_class) }

    describe '#find' do
      let(:key) { "test" }
      let(:definition) { "title 'foo'" }

      it 'finds one questionnaire' do
        questionnaire = questionnaire_class.new(key, definition)
        questionnaire_class.stub(:new).with(key, definition).and_return { questionnaire }
        File.open("/tmp/#{key}.rb", "w") {|f| f.write definition}
        questionnaire_finder.find(key).should == questionnaire
      end

      it "marks found questionnaires as persisted" do
        questionnaire_finder.stub(:exists? => true)
        File.stub(:read => "title \"hallo wereld\"")
        questionnaire_finder.find(key).persisted.should be_true
      end

      it 'raises RecordNotFound if it doesnt exist' do
        questionnaire_finder.stub(:exists?).with(key).and_return(false)
        expect {
          questionnaire_finder.find(key)
        }.to raise_error(QuestionnaireFinder::RecordNotFound)
      end
    end

    describe '#exists?' do
      it 'returns true if file exists' do
        FileUtils.touch("/tmp/test.rb")
        questionnaire_finder.exists?("test").should be_true
      end

      it 'returns false if file does not exist' do
        questionnaire_finder.exists?("test").should be_false
      end
    end

    describe '#all' do
      it 'finds all questionnaires' do
        FileUtils.touch("/tmp/a.rb")
        FileUtils.touch("/tmp/b.rb")
        questionnaire_finder.all.map(&:key).should == ['a', 'b']
      end
    end
  end
end

require 'fakefs/spec_helpers'
require 'spec_helper'

module Quby::QuestionnaireRepos
  describe DiskRepo do
    include FakeFS::SpecHelpers

    before { FileUtils.mkdir_p("/tmp") }

    let(:questionnaire_class) do
      Class.new do
        attr_reader :key, :definition
        attr_accessor :last_update

        def initialize(key, definition, last_update = Time.now)
          @key = key
          @definition = definition
          @last_update = last_update
        end
      end
    end

    let(:questionnaire_finder) { DiskRepo.new("/tmp", questionnaire_class) }

    describe '#find' do
      let(:key) { "test" }
      let(:definition) { "title 'foo'" }
      let(:definition_2) { "title 'bar'" }

      it 'finds one questionnaire' do
        questionnaire = questionnaire_class.new(key, definition)
        questionnaire_class.stub(:new).with(key, definition, anything).and_return { questionnaire }

        File.open("/tmp/#{key}.rb", "w") { |f| f.write definition }
        questionnaire_finder.find(key).should eq questionnaire
      end

      it 'raises RecordNotFound if it doesnt exist' do
        questionnaire_finder.stub(:exists?).with(key).and_return(false)
        expect { questionnaire_finder.find(key) }.to raise_error(DiskRepo::RecordNotFound)
      end

      it 'reloads a questionnaire if the definition updated on disk' do

        File.open("/tmp/#{key}.rb", "w") { |f| f.write definition }

        found_questionnaire = questionnaire_finder.find(key)
        found_questionnaire.definition.should eq definition

        File.open("/tmp/#{key}.rb", "w") { |f| f.write definition_2 }

        # FakeFS does not implement ctime yet
        File.stub(ctime: Time.now + 10.minutes)
        found_questionnaire = questionnaire_finder.find(key)
        found_questionnaire.definition.should eq definition_2
      end

      it 'uses the cache if a questionnaire definition on disk has not changed' do

        File.open("/tmp/#{key}.rb", "w") { |f| f.write definition }
        questionnaire_finder.find(key)

        # Second find should hit cache
        File.should_not_receive(:read)
        questionnaire_finder.find(key)
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
        questionnaire_finder.all.map(&:key).should eq %w(a b)
      end
    end
  end
end

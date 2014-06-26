require 'fakefs/spec_helpers'
require 'spec_helper'

module Quby::Questionnaires::Repos
  describe DiskRepo do
    context 'when integrated' do
      before { Quby.questionnaires_path = Rails.root.join('..', '..', 'spec', 'fixtures') }
      it_behaves_like 'a valid backend for the questionnaires api'
    end

    context 'in isolation' do
      include FakeFS::SpecHelpers
      before { FileUtils.mkdir_p("/tmp") }
      let(:questionnaire_finder)  { DiskRepo.new("/tmp") }

      describe '#find' do
        let(:key) { "test" }
        let(:definition) { "title 'foo'" }
        let(:definition_2) { "title 'bar'" }

        it 'finds one questionnaire' do
          File.open("/tmp/#{key}.rb", "w") { |f| f.write definition }
          questionnaire = questionnaire_finder.find(key)
          questionnaire.key.should eq(key)
          questionnaire.title.should eq 'foo'
        end

        it 'raises RecordNotFound if it doesnt exist' do
          questionnaire_finder.stub(:exists?).with(key).and_return(false)
          expect { questionnaire_finder.find(key) }.to raise_error(QuestionnaireNotFound)
        end

        it 'reloads a questionnaire if the definition updated on disk' do
          File.open("/tmp/#{key}.rb", "w") { |f| f.write definition }
          found_questionnaire = questionnaire_finder.find(key)
          found_questionnaire.title.should eq 'foo'

          File.open("/tmp/#{key}.rb", "w") { |f| f.write definition_2 }
          File.stub(ctime: Time.now + 10.minutes) # FakeFS does not implement ctime yet
          found_questionnaire = questionnaire_finder.find(key)
          found_questionnaire.title.should eq 'bar'
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
end

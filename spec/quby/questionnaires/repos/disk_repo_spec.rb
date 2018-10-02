# frozen_string_literal: true

require 'fakefs/spec_helpers'
require 'spec_helper'

module Quby::Questionnaires::Repos
  describe DiskRepo do
    it_behaves_like 'a questionnaire repository' do
      before { @repo_path = Dir.mktmpdir }
      after  { FileUtils.remove_entry_secure(@repo_path) }

      let(:repo) { DiskRepo.new(@repo_path) }
    end

    context 'when integrated' do
      it_behaves_like 'a valid backend for the questionnaires api'
    end

    context 'in isolation' do
      include FakeFS::SpecHelpers
      before { FileUtils.mkdir_p("/tmp") }
      let(:repo) { DiskRepo.new("/tmp") }

      describe '#find' do
        let(:key) { "test" }
        let(:sourcecode) { "title 'foo'" }

        it 'finds one questionnaire' do
          File.open("/tmp/#{key}.rb", "w") { |f| f.write sourcecode }
          questionnaire = repo.find(key)
          questionnaire.key.should eq(key)
          questionnaire.sourcecode.should eq "title 'foo'"
        end

        it 'raises QuestionnaireNotFound if it doesnt exist' do
          repo.stub(:exists?).with(key).and_return(false)
          expect { repo.find(key) }.to raise_error(QuestionnaireNotFound)
        end
      end

      describe '#exists?' do
        it 'returns true if file exists' do
          FileUtils.touch("/tmp/test.rb")
          repo.exists?("test").should be_truthy
        end

        it 'returns false if file does not exist' do
          repo.exists?("test").should be_falsey
        end
      end

      describe '#all' do
        it 'finds all questionnaires' do
          FileUtils.touch("/tmp/a.rb")
          FileUtils.touch("/tmp/b.rb")
          repo.all.map(&:key).should eq %w(a b)
        end
      end
    end
  end
end

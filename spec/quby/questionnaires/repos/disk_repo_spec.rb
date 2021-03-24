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
      it_behaves_like 'a valid backend for the questionnaires api' do
        let(:repo) { DiskRepo.new('./spec/fixtures') }
      end
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
          expect(questionnaire.key).to eq(key)
          expect(questionnaire.sourcecode).to eq "title 'foo'"
        end

        it 'raises QuestionnaireNotFound if it doesnt exist' do
          allow(repo).to receive(:exists?).and_return(false)
          expect { repo.find(key) }.to raise_error(QuestionnaireNotFound)
        end
      end

      describe '#exists?' do
        it 'returns true if file exists' do
          FileUtils.touch("/tmp/test.rb")
          expect(repo.exists?("test")).to be_truthy
        end

        it 'returns false if file does not exist' do
          expect(repo.exists?("test")).to be_falsey
        end
      end

      describe '#all' do
        it 'finds all questionnaires' do
          FileUtils.touch("/tmp/a.rb")
          FileUtils.touch("/tmp/b.rb")
          expect(repo.all.map(&:key)).to eq %w(a b)
        end
      end
    end
  end
end

require 'fakefs/spec_helpers'
require 'spec_helper'

module Quby::Questionnaires::Repos
  describe MemoryRepo do
    it_behaves_like 'a questionnaire repository'

    context 'when integrated' do
      it_behaves_like 'a valid backend for the questionnaires api'
    end

    context 'in isolation' do
      let(:repo) { MemoryRepo.new("test" => "title 'foo'", 'a' => "", 'b' => "") }

      describe '#find' do
        it 'finds one questionnaire' do
          questionnaire = repo.find('test')
          questionnaire.key.should eq('test')
          questionnaire.title.should eq 'foo'
        end

        it 'raises RecordNotFound if it doesnt exist' do
          expect { repo.find('unknown') }.to raise_error(QuestionnaireNotFound)
        end
      end

      describe '#exists?' do
        it 'returns true if questionnaire was added' do
          repo.exists?("test").should be_true
        end

        it 'returns false if questionnaire was not added' do
          repo.exists?("unknown").should be_false
        end
      end

      describe '#all' do
        it 'finds all questionnaires' do
          repo.all.map(&:key).should eq %w(test a b)
        end
      end
    end
  end
end

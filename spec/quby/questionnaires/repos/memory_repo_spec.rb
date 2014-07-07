require 'fakefs/spec_helpers'
require 'spec_helper'

module Quby::Questionnaires::Repos
  describe MemoryRepo do
    it_behaves_like 'a valid backend for the questionnaires api'

    it_behaves_like 'a questionnaire repository' do
      let(:repo) { MemoryRepo.new }
    end

    describe '#initialize' do
      it 'accepts a hash of keys and definitions to start with' do
        repo = MemoryRepo.new("test1" => "title 'Foo'",
                              "test2" => "title 'Bar'")

        expect(repo.exists?('test1')).to be_true
        expect(repo.find('test1').sourcecode).to eq("title 'Foo'")

        expect(repo.exists?('test2')).to be_true
        expect(repo.find('test2').sourcecode).to eq("title 'Bar'")

        expect(repo.exists?('test3')).to be_false
      end
    end
  end
end

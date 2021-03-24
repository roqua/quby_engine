# frozen_string_literal: true

require 'fakefs/spec_helpers'
require 'spec_helper'

module Quby::Questionnaires::Repos
  describe MemoryRepo do
    it_behaves_like 'a valid backend for the questionnaires api' do
      let(:repo) { MemoryRepo.new('simple' => File.read('./spec/fixtures/simple.rb'),
                                  'simple_with_outcome' => File.read('./spec/fixtures/simple_with_outcome.rb')) }
    end

    it_behaves_like 'a questionnaire repository' do
      let(:repo) { MemoryRepo.new }
    end

    describe '#initialize' do
      it 'accepts a hash of keys and definitions to start with' do
        repo = MemoryRepo.new("test1" => "title 'Foo'",
                              "test2" => "title 'Bar'")

        expect(repo.exists?('test1')).to be_truthy
        expect(repo.find('test1').sourcecode).to eq("title 'Foo'")

        expect(repo.exists?('test2')).to be_truthy
        expect(repo.find('test2').sourcecode).to eq("title 'Bar'")

        expect(repo.exists?('test3')).to be_falsey
      end
    end
  end
end

require 'spec_helper'

describe Quby::TableBackend::DiskTree do
  let(:tree) { described_class.new('test_tree/test.csv') }
  let(:fixture_root) { Rails.root.join('..', 'fixtures', 'lookup_tables').to_s }
  before do
    allow(Quby).to receive(:lookup_table_path).and_return(fixture_root)
  end

  describe '#initialize' do
    let(:expected_path) { Pathname.new(fixture_root).join('test_tree') }

    it 'reads the csv file' do
      expect(CSV).to receive(:read).and_call_original
      tree
    end
  end

  describe 'lookup' do
    it 'ignores parameter ordering' do
      params = {age: 11, raw: 61, scale: 'Initiatief nemen', gender: 'f'}
      params2 = {gender: 'f', scale: 'Initiatief nemen', raw: 61, age: 11}
      expect(tree.lookup(params)).to eq(tree.lookup(params2))
    end

    it 'returns Not found when a param is not mached' do
      params = {age: 42, raw: 61, scale: 'Initiatief nemen', gender: 'f'}
      expect(tree.lookup(params)).to eq('Not found')
    end

    it 'can handle infinity in csv data' do
      params = {age: 10, raw: 94, scale: 'Metacognitie index', gender: 'm'}
      expect(tree.lookup(params)).to eq(132)
    end
  end
end

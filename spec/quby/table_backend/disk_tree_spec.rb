require 'spec_helper'

describe Quby::TableBackend::DiskTree do
  let(:tree) { described_class.new('test_tree/test') }
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
      expect(tree.lookup(params)).to_not be_nil
      expect(tree.lookup(params)).to eq(tree.lookup(params2))
    end

    it 'returns nil when a parameter value is not mached' do
      params = {age: 42, raw: 61, scale: 'Initiatief nemen', gender: 'f'}
      expect(tree.lookup(params)).to eq(nil)
    end

    it 'can handle infinity in csv data' do
      params = {age: 10, raw: 94, scale: 'Metacognitie index', gender: 'm'}
      expect(tree.lookup(params)).to eq(132)
    end

    describe 'parameter validation' do
      it 'raises when parameter keys do not match header keys' do
        params = {foo: :bar}
        expect { tree.lookup(params) }.to raise_error(RuntimeError, 'Incompatible score parameters found')
      end

      it 'raises when a key is missing' do
        params = {age: 11, scale: 'Initiatief nemen', gender: 'f'}
        expect { tree.lookup(params) }.to raise_error(RuntimeError, 'Incompatible score parameters found')
      end
    end
  end
end

require 'spec_helper'

describe Quby::TableBackend::RangeTree do
  let(:csv_key) { 'test' }
  let(:data) { Quby.lookup_table_repo.retrieve(csv_key) }
  let(:tree) { described_class.new(data.shift, data.shift, data) }

  describe '#tree' do
    it 'returns a hash' do
      expect(tree.send(:tree)).to be_a(Hash)
    end

    context 'invalid csv data' do
      let(:csv_key) { 'bad_range' }
      it 'fails when csv data contains a range between two equal values' do
        expect { tree.send(:tree) }.to raise_error(RuntimeError, 'Cannot create range between two equal values')
      end
    end
  end

  describe '#lookup' do
    it 'ignores parameter ordering' do
      params = {age: 10, raw: 15, scale: 'Inhibitie', gender: 'male'}
      params2 = {gender: 'male', scale: 'Inhibitie', raw: 15, age: 10}
      expect(tree.lookup(params)).to_not be_nil
      expect(tree.lookup(params)).to eq(tree.lookup(params2))
    end

    it 'returns nil and notifies AppSignal when a lookup fails' do
      expect(Roqua::Support::Errors).to receive(:report).exactly(4).times

      # Age too low
      params = {age: 9, raw: 25, scale: 'Inhibitie', gender: 'male'}
      expect(tree.lookup(params)).to eq(nil)

      # Age too high
      params = {age: 35, raw: 25, scale: 'Inhibitie', gender: 'male'}
      expect(tree.lookup(params)).to eq(nil)

      # Unknown scale
      params = {age: 10, raw: 25, scale: 'Niet gevonden', gender: 'male'}
      expect(tree.lookup(params)).to eq(nil)

      # Unknown gender
      params = {age: 10, raw: 25, scale: 'Inhibitie', gender: '?'}
      expect(tree.lookup(params)).to eq(nil)
    end

    it 'handles minfinity' do
      params = {age: 10, raw: 5, scale: 'Inhibitie', gender: 'male'}
      expect(tree.lookup(params)).to eq(39)
    end

    it 'handles infinity' do
      params = {age: 10, raw: 96, scale: 'Inhibitie', gender: 'male'}
      expect(tree.lookup(params)).to eq(75)
    end

    it 'handles normal ranges' do
      params = {age: 10, raw: 15, scale: 'Inhibitie', gender: 'male'}
      expect(tree.lookup(params)).to eq(42)
    end

    it 'handles float values in query parameters' do
      params = {age: 10.2, raw: 96.9, scale: 'Inhibitie', gender: 'male'}
      expect(tree.lookup(params)).to eq(75)
    end

    it 'treats symbols as strings in query parameters' do
      params = {age: 10.2, raw: 96.9, scale: 'Inhibitie', gender: :male}
      expect(tree.lookup(params)).to eq(75)
    end

    describe 'definition containing range with float values' do
      let(:csv_key) { 'float_test' }

      it 'returns the correct scores' do
        params = {age: 10, raw: 15.8, scale: 'Inhibitie', gender: 'male'}
        expect(tree.lookup(params)).to eq(42)

        params = {age: 10.2, raw: 96.9, scale: 'Inhibitie', gender: 'male'}
        expect(tree.lookup(params)).to eq(75)
      end
    end

    describe 'definition containing float values' do
      let(:csv_key) { 'test2' }

      it 'returns the correct scores when using integers in lookup path' do
        params = {scale: 'Inhibitie', raw: 17}
        expect(tree.lookup(params)).to eq(71)
      end

      it 'returns the correct scores when using floats in lookup path' do
        params = {scale: 'Inhibitie', raw: 17.0}
        expect(tree.lookup(params)).to eq(71)
      end
    end

    describe 'parameter validation' do
      it 'raises when parameter keys do not match header keys' do
        params = {foo: :bar}
        expect { tree.lookup(params) }.to raise_error(RuntimeError, 'Incompatible score parameters found')
      end

      it 'raises when a key is missing' do
        params = {age: 10, scale: 'Inhibitie', gender: 'male'}
        expect { tree.lookup(params) }.to raise_error(RuntimeError, 'Incompatible score parameters found')
      end

      it 'raises when extra keys are given' do
        params = {age: 10, scale: 'Inhibitie', gender: 'male', raw: 25, foo: :bar}
        expect { tree.lookup(params) }.to raise_error(RuntimeError, 'Incompatible score parameters found')
      end
    end
  end
end

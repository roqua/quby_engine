require 'spec_helper'

describe Quby::TableBackend::RangeTree do
  let(:tree) do
    described_class.new(
      levels: ["scale", "gender", "age", "raw", "norm"],
      tree: {
        "Inhibitie" => {
          "male" => {
            (10.0...11.0) => {
              (-Float::INFINITY...10.0) => 39.0,
              (10.0...20.0) => 42.0,
              (20.0...30.0) => 71.0,
              (30.0...Float::INFINITY) => 75.0
            }
          }
        }
      }
    )
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
      let(:tree) do
        described_class.new(
          levels: ["scale", "gender", "age", "raw", "norm"],
          tree: {
            "Inhibitie" => {
              "male" => {
                (10.0...11.0) => {
                  (-Float::INFINITY...10.5) => 39.0,
                  (10.5...20.1) => 42.0,
                  (20.1...30.7) => 71.0,
                  (30.7...Float::INFINITY) => 75.0
                }
              }
            }
          }
        )
      end

      it 'returns the correct scores' do
        params = {age: 10, raw: 15.8, scale: 'Inhibitie', gender: 'male'}
        expect(tree.lookup(params)).to eq(42)

        params = {age: 10.2, raw: 96.9, scale: 'Inhibitie', gender: 'male'}
        expect(tree.lookup(params)).to eq(75)
      end
    end

    describe 'definition containing float values' do
      let(:tree) do
        described_class.new(
          levels: ["scale", "raw", "norm"],
          tree: {"Inhibitie" => {15.0=>39.0, 16.0=>42.0, 17.0=>71.0, 18.0=>75.0}}
        )
      end

      it 'returns the correct scores when using integers in lookup path' do
        params = {scale: 'Inhibitie', raw: 17}
        expect(tree.lookup(params)).to eq(71)
      end

      it 'returns the correct scores when using floats in lookup path' do
        params = {scale: 'Inhibitie', raw: 17.0}
        expect(tree.lookup(params)).to eq(71)
      end
    end

    describe 'array keys in tree' do
      let(:tree) { described_class.new levels: ['value', 'res'], tree: {[1,5] => 6}}

      it 'returns the correct result if the array includes the value' do
        expect(tree.lookup(value: 5)).to eq 6
      end
    end

    describe 'array leaves' do
      it 'returns the leaf fully' do
        tree = described_class.new levels: ['key', 'leaf'], tree: {a: [1, 2, 3], b: [9, 8, 7]}
        expect(tree.lookup(key: :a)).to eq([1, 2, 3])
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

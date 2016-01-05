require 'spec_helper'

module Quby
  describe LookupTable do
    let(:table) { described_class.new('test_table') }
    let(:expected_backing) { double.as_null_object }

    before do
      allow(described_class.backend_class).to receive(:new).and_return(expected_backing)
    end

    describe '#initialize' do
      it 'initializes the backing' do
        backing = table.instance_variable_get(:@backing)
        expect(backing).to eq(expected_backing)
      end
    end

    describe '#lookup' do
      it 'passes lookup calls on to the backing' do
        parameters = {a: 1}
        expect(table.instance_variable_get(:@backing)).to receive(:lookup).with(parameters)
        table.lookup(parameters)
      end
    end
  end
end

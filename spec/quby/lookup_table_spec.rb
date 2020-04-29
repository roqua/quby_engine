# frozen_string_literal: true

require 'spec_helper'

module Quby
  describe LookupTable do
    let(:table) { described_class.new('test') }
    let(:fake_backing) { double.as_null_object }

    describe '#initialize' do
      it 'calls data to initialize the disktree' do
        data_double = double()
        expect_any_instance_of(described_class).to receive(:data).and_return(data_double)
        expect(Quby::TableBackend::DiskTree).to receive(:new).with(data_double).and_return(fake_backing)
        table
      end
    end

    describe '#lookup' do
      it 'passes lookup calls on to the backing' do
        expect(Quby::TableBackend::DiskTree).to receive(:new).and_return(fake_backing)
        parameters = {a: 1}
        expect(table.instance_variable_get(:@backing)).to receive(:lookup).with(parameters)
        table.lookup(parameters)
      end
    end

    describe '#data' do
      it 'calls Quby.csv_repo.retrieve(table.key)' do
        table
        expect(Quby.csv_repo).to receive(:retrieve).with(table.key)
        table.data
      end
    end
  end
end

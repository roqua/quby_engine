# frozen_string_literal: true

require 'spec_helper'

module Quby
  describe LookupTable do
    let(:table) { described_class.new('test') }
    let(:fake_backing) { double(:"present?" => true).as_null_object }

    describe '#lookup' do
      it 'passes lookup calls on to the backing' do
        expect(Quby::TableBackend::RangeTree).to receive(:new).and_return(fake_backing)
        parameters = {a: 1}
        expect(table.backing).to receive(:lookup).with(parameters)
        table.lookup(parameters)
      end

      it 'initializes the disktree lazily' do
        headers = double
        compare = double
        data = double
        data_double = [headers, compare, data]
        table
        expect_any_instance_of(described_class).to receive(:data).and_return(data_double)
        expect(Quby::TableBackend::RangeTree).to receive(:new).with(headers, compare, [data]).and_return(fake_backing)
        table.lookup(some: :thing)
      end
    end

    describe '#data' do
      it 'calls Quby.lookup_table_repo.retrieve(table.key)' do
        table
        expect(Quby.lookup_table_repo).to receive(:retrieve).with(table.key)
        table.data
      end
    end
  end
end

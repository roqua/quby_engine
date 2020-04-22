# frozen_string_literal: true

require 'spec_helper'

module Quby
  describe LookupTable do
    let(:table) { described_class.new('test_tree') }
    let(:fake_backing) { double.as_null_object }

    describe '#initialize' do
      it 'initializes the backing `from_file`' do
        expect(Quby::TableBackend::DiskTree).to receive(:from_file).with('test_tree').and_return(fake_backing)
        table
      end

      describe 'when running in quby_admin' do
        before do
          allow(described_class).to receive(:parent_application).and_return('QubyAdmin')
        end
        it 'constructs the backing `from_git` instead of `from_file`' do
          expect(Quby::TableBackend::DiskTree).to receive(:from_git).with('test_tree').and_return(fake_backing)
          table
        end
      end
    end

    describe '#lookup' do
      it 'passes lookup calls on to the backing' do
        expect(Quby::TableBackend::DiskTree).to receive(:from_file).with('test_tree').and_return(fake_backing)
        parameters = {a: 1}
        expect(table.instance_variable_get(:@backing)).to receive(:lookup).with(parameters)
        table.lookup(parameters)
      end
    end
  end
end

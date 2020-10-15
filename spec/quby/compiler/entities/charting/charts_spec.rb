# frozen_string_literal: true

require 'spec_helper'

module Quby::Compiler::Entities
  module Charting
    describe Charts do
      let(:charts) { Charts.new }
      let(:chart)  { double(key: 'foobar') }

      it 'stores charts' do
        charts.add chart
        expect(charts.size).to eq 1
      end

      it 'does not store charts with duplicate keys' do
        charts.add chart
        expect { charts.add chart }.to raise_error(/Duplicate/)
      end

      it 'finds charts' do
        charts.add chart
        expect(charts.find(chart.key)).to eq chart
      end

      it 'knows the number of charts' do
        charts.add double(key: 1)
        charts.add double(key: 2)
        charts.add double(key: 3)
        expect(charts.size).to eq 3
      end
    end
  end
end

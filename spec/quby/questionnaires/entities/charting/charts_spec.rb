# frozen_string_literal: true

require 'spec_helper'

module Quby::Questionnaires::Entities
  module Charting
    describe Charts do
      let(:charts) { Charts.new }
      let(:chart)  { double(key: 'foobar') }

      it 'stores charts' do
        charts.add chart
        charts.size.should == 1
      end

      it 'does not store charts with duplicate keys' do
        charts.add chart
        expect { charts.add chart }.to raise_error(/Duplicate/)
      end

      it 'finds charts' do
        charts.add chart
        charts.find(chart.key).should == chart
      end

      it 'knows the number of charts' do
        charts.add double(key: 1)
        charts.add double(key: 2)
        charts.add double(key: 3)
        charts.size.should == 3
      end
    end
  end
end

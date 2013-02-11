require 'spec_helper'

module Quby
  module Charting
    describe LineChart do
      it_behaves_like Chart

      it 'can set tonality to valid values only' do
        chart = LineChart.new(:tot, tonality: :higher_is_better)
        chart.tonality.should == :higher_is_better

        expect { LineChart.new(:tot, tonality: :positive) }.to raise_error(/Invalid tonality/)
      end
    end
  end
end
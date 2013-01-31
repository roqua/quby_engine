require 'spec_helper'

module Quby
  module Charting
    describe LineChart do
      it 'initializes with a key and options' do
        LineChart.new(:tot, title: "My Title").should be
      end

      it 'coerces keys to be symbols' do
        LineChart.new('tot').key.should == :tot
      end

      it 'has scores' do
        LineChart.new(:tot, scores: [:tot, :sym]).scores.should == [:tot, :sym]
      end

      it 'can set tonality to valid values only' do
        chart = LineChart.new(:tot, tonality: :higher_is_better)
        chart.tonality.should == :higher_is_better

        expect { LineChart.new(:tot, tonality: :positive) }.to raise_error(/Invalid tonality/)
      end
    end
  end
end
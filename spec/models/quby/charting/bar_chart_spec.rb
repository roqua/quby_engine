require 'spec_helper'

module Quby
  module Charting
    describe BarChart do
      it 'initializes with a key and options' do
        BarChart.new(:tot, title: "My Title").should be
      end

      it 'coerces keys to be symbols' do
        BarChart.new('tot').key.should == :tot
      end

      it 'has scores' do
        score1, score2 = stub, stub
        BarChart.new(:tot, scores: [score1, score2]).scores.should == [score1, score2]
      end
    end
  end
end
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
    end
  end
end
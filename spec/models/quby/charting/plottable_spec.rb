require 'spec_helper'

module Quby
  module Charting
    describe Plottable do
      it 'stores the key' do
        score = Plottable.new(:tot)
        score.key.should == :tot
      end

      it 'stores the label' do
        score = Plottable.new(:tot, label: 'Label')
        score.label.should == 'Label'
      end

      it 'has a default plotted key' do
        Plottable.new(:tot).plotted_key.should == :value
      end

      it 'stores the plotted key' do
        score = Plottable.new(:tot, plotted_key: :tscore)
        score.plotted_key.should == :tscore
      end
    end
  end
end

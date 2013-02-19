require 'spec_helper'

module Quby
  module Charting
    describe PlottedScore do
      it 'stores the score key' do
        score = PlottedScore.new(:tot)
        score.key.should == :tot
      end

      it 'stores the score label' do
        score = PlottedScore.new(:tot, label: 'Label')
        score.label.should == 'Label'
      end

      it 'has a default plotted key' do
        PlottedScore.new(:tot).plotted_key.should == :value
      end

      it 'stores the plotted key' do
        score = PlottedScore.new(:tot, plotted_key: :tscore)
        score.plotted_key.should == :tscore
      end
    end
  end
end

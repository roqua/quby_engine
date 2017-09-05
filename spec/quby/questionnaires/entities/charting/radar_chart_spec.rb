require 'spec_helper'

module Quby::Questionnaires::Entities
  module Charting
    describe RadarChart do
      it_behaves_like Chart

      it 'has a type' do
        RadarChart.new(:tot).type.should == 'radar_chart'
      end

      it 'can set plotlines' do
        chart = RadarChart.new(:tot, plotlines: [{value: 40, color: :red, width: 2}])
        expect(chart.plotlines).to eq([{value: 40, color: :red, width: 2}])
      end
    end
  end
end

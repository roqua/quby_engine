# frozen_string_literal: true

require 'spec_helper'

module Quby::Questionnaires::Entities
  module Charting
    describe RadarChart do
      it_behaves_like Chart

      it 'has a type' do
        expect(RadarChart.new(key: :tot).type).to eq 'radar_chart'
      end

      it 'can set plotlines' do
        chart = RadarChart.new(key: :tot, plotlines: [{value: 40, color: :red, width: 1, zIndex: 3}])
        expect(chart.plotlines).to eq([{value: 40, color: :red, width: 1, zIndex: 3}])
      end
    end
  end
end

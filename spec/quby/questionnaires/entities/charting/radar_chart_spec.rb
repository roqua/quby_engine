# frozen_string_literal: true

require 'spec_helper'

module Quby::Questionnaires::Entities
  module Charting
    describe RadarChart do
      it_behaves_like Chart

      it 'has a type' do
        expect(RadarChart.new(:tot).type).to eq 'radar_chart'
      end
    end
  end
end

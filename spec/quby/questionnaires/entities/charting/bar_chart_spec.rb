# frozen_string_literal: true

require 'spec_helper'

module Quby::Questionnaires::Entities
  module Charting
    describe BarChart do
      it_behaves_like Chart

      it 'can set plotlines' do
        chart = BarChart.new(:tot, plotlines: [{value: 40, color: :red, width: 1, zIndex: 3}])
        expect(chart.plotlines).to eq([{value: 40, color: :red, width: 1, zIndex: 3}])
      end
    end
  end
end

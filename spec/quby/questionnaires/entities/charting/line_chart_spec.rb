# frozen_string_literal: true

require 'spec_helper'

module Quby::Questionnaires::Entities
  module Charting
    describe LineChart do
      it_behaves_like Chart

      it 'can set tonality to valid values only' do
        chart = LineChart.new(:tot, tonality: :higher_is_better)
        expect(chart.tonality).to eq :higher_is_better

        expect { LineChart.new(:tot, tonality: :positive) }.to raise_error(/Invalid tonality/)
      end

      it 'has a type' do
        LineChart.new(:tot).type.should == 'line_chart'
      end
    end
  end
end

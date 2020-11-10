# frozen_string_literal: true

require 'spec_helper'

module Quby::Questionnaires::Entities
  module Charting
    describe LineChart do
      it_behaves_like Chart

      it 'can set tonality to valid values only' do
        chart = LineChart.new(key: :tot, tonality: :higher_is_better)
        expect(chart.tonality).to eq :higher_is_better

        expect { LineChart.new(key: :tot, tonality: :positive) }.to raise_error(/tonality violates constraints/)
      end

      it 'has a type' do
        expect(LineChart.new(key: :tot).type).to eq 'line_chart'
      end
    end
  end
end

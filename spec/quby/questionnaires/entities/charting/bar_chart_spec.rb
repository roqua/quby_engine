# frozen_string_literal: true

require 'spec_helper'

module Quby::Questionnaires::Entities
  module Charting
    describe BarChart do
      it_behaves_like Chart

      it 'has a type' do
        expect(BarChart.new(:tot).type).to eq 'bar_chart'
      end
    end
  end
end

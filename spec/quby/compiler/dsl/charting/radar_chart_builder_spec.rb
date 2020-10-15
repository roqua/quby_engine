# frozen_string_literal: true

require 'spec_helper'

module Quby::Compiler::DSL
  describe RadarChartBuilder do
    it_behaves_like ChartBuilder

    let(:questionnaire) { double(key: 'questionnaire_key') }

    it 'makes a radar chart' do
      expect(dsl { }).to be_an_instance_of(::Quby::Compiler::Entities::Charting::RadarChart)
    end

    it 'sets y-axis range' do
      expect(dsl { range 0..40 }.y_range).to eq (0..40)
    end

    it 'sets y-axis tick interval' do
      expect(dsl { tick_interval 1 }.tick_interval).to eq 1
    end

    it 'sets plotlines' do
      plotlines =
        dsl {
          plotline 40, :orange
          plotline 60, :red
        }.plotlines

      expect(plotlines).to eq [
        {value: 40, color: :orange, width: 1, zIndex: 3},
        {value: 60, color: :red, width: 1, zIndex: 3}
      ]
    end

    def dsl(key = :test, options = {}, &block)
      builder = RadarChartBuilder.new(questionnaire, key, options)
      builder.build(&block)
    end
  end
end

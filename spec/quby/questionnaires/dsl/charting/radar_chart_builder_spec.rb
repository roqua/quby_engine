# frozen_string_literal: true

require 'spec_helper'

module Quby::Questionnaires::DSL
  describe RadarChartBuilder do
    it_behaves_like ChartBuilder

    let(:questionnaire) { double(key: 'questionnaire_key') }

    it 'makes a radar chart' do
      dsl { }.should be_an_instance_of(::Quby::Questionnaires::Entities::Charting::RadarChart)
    end

    it 'sets y-axis range' do
      dsl { range 0..40 }.y_range.should == (0..40)
    end

    it 'sets y-axis tick interval' do
      dsl { tick_interval 1 }.tick_interval.should == 1
    end

    it 'sets plotlines' do
      dsl {
        plotline 40, :orange
        plotline 60, :red
      }.plotlines.should == [
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

require 'spec_helper'

module Quby
  module QuestionnaireDsl
    describe RadarChartBuilder do
      let(:questionnaire) { stub(key: 'questionnaire_key') }

      it 'makes a radar chart' do
        dsl { }.should be_an_instance_of(::Quby::Charting::RadarChart)
      end

      it 'subclasses ChartBuilder' do
        (RadarChartBuilder < (::Quby::QuestionnaireDsl::ChartBuilder)).should be_true
      end

      def dsl(key = :test, options = {}, &block)
        builder = RadarChartBuilder.new(questionnaire, key, options)
        builder.build(&block)
      end
    end
  end
end

require 'spec_helper'

module Quby
  module QuestionnaireDsl
    describe ChartBuilder do

      let(:plottable_key) { 'some_key' }
      let(:plottable) { Quby::Score.new plottable_key, {} }
      let(:questionnaire) do
        stub(:key => 'questionnaire_key').tap do |questionnaire|
          questionnaire.stub(:find_plottable).with(plottable_key).and_return plottable
        end
      end
      let(:chart_plottables) { [] }
      let(:chart) { mock(plottables: chart_plottables)}
      before { ChartBuilder.set_chart_class mock(new: chart) }
      let(:chart_builder) { ChartBuilder.new questionnaire, 'chart_key' }

      describe '#plot' do
        it 'fetches a plottable by key from the questionnaire' do
          questionnaire.should_receive(:find_plottable).with(plottable_key)
          chart_builder.plot plottable_key
        end

        it 'creates a plottable with the options merged into the plottable options' do
          plottable.stub(options: {some: 'options', other: 'options'})
          Quby::Charting::Plottable.should_receive(:new)
                                   .with(plottable.key, some: 'different_options', other: 'options',
                                         questionnaire_key: 'questionnaire_key')
          chart_builder.plot plottable_key, some: 'different_options'
        end
      end

    end
  end
end
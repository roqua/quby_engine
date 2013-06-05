require 'spec_helper'

module Quby
  module QuestionnaireDsl
    describe ChartBuilder do

      let(:plottable_key) { 'some_key' }
      let(:plottable) { mock(options: {}, key: 'plottable_key') }
      let(:questionnaire) do
        mock.tap do |questionnaire|
          questionnaire.stub(:find_plottable).with(plottable_key).and_return plottable
        end
      end
      let(:chart_plottables) { [] }
      let(:chart) { mock(plottables: chart_plottables)}
      before { ChartBuilder.set_chart_class mock(new: chart) }
      let(:chart_builder) { ChartBuilder.new questionnaire, 'chart_key' }

      describe '#plot' do
        it 'creates a plottable with the label from the options given' do
          Quby::Charting::Plottable.should_receive(:new).with(plottable.key, label: 'some_label', plotted_key: :value)
          chart_builder.plot plottable_key, :value, label: 'some_label'
        end
      end

    end
  end
end
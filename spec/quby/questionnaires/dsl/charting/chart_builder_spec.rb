require 'spec_helper'

module Quby::Questionnaires::DSL
  describe ChartBuilder do

    let(:plottable_key) { 'some_key' }
    let(:plottable) { Quby::Questionnaires::Entities::ScoreCalculation.new plottable_key, {} }
    let(:questionnaire) do
      double(key: 'questionnaire_key').tap do |questionnaire|
        allow(questionnaire).to receive(:find_plottable).with(plottable_key).and_return plottable
      end
    end
    let(:chart_plottables) { [] }
    let(:chart) { double(plottables: chart_plottables) }
    before { ChartBuilder.set_chart_class(double(new: chart)) }
    let(:chart_builder) { ChartBuilder.new questionnaire, 'chart_key' }

    describe '#plot' do
      it 'fetches a plottable by key from the questionnaire' do
        expect(questionnaire).to receive(:find_plottable).with(plottable_key)
        chart_builder.plot plottable_key
      end

      it 'creates a plottable with the options merged into the plottable options' do
        allow(plottable).to receive(:options).and_return({some: 'options', other: 'options'})
        expect(Quby::Questionnaires::Entities::Charting::Plottable).to receive(:new)
                                .with(plottable_key, some: 'different_options', other: 'options',
                                                     questionnaire_key: 'questionnaire_key')
        chart_builder.plot plottable_key, some: 'different_options'
      end

      it 'sets the label from a question title when no label is present' do
        plottable = Quby::Questionnaires::Entities::Question.new plottable_key, title: 'some_title'
        allow(questionnaire).to receive(:find_plottable).with(plottable_key).and_return(plottable)
        expect(Quby::Questionnaires::Entities::Charting::Plottable).to receive(:new)
                                .with(plottable_key, questionnaire_key: 'questionnaire_key', label: 'some_title')
        chart_builder.plot plottable_key
      end

      it 'does not set the label when it is given in the options' do
        plottable = Quby::Questionnaires::Entities::Question.new plottable_key, title: 'some_title'
        allow(questionnaire).to receive(:find_plottable).with(plottable_key).and_return(plottable)
        expect(Quby::Questionnaires::Entities::Charting::Plottable).to receive(:new)
                                .with(plottable_key, questionnaire_key: 'questionnaire_key', label: 'some_label')
        chart_builder.plot plottable_key, label: 'some_label'
      end
    end

  end
end

require 'spec_helper'

module Quby::Questionnaires::DSL
  describe ChartBuilder do

    let(:plottable_key) { 'some_key' }
    let(:plottable) { Quby::Questionnaires::Entities::ScoreCalculation.new plottable_key, {} }
    let(:questionnaire) do
      double(key: 'questionnaire_key').tap do |questionnaire|
        questionnaire.stub(:find_plottable).with(plottable_key).and_return plottable
      end
    end
    let(:chart_plottables) { [] }
    let(:chart_class) { Quby::Questionnaires::Entities::Charting::Chart }
    before { ChartBuilder.set_chart_class(chart_class) }
    let(:chart_builder) { ChartBuilder.new questionnaire, 'chart_key' }

    describe '#plot' do
      it 'fetches a plottable by key from the questionnaire' do
        questionnaire.should_receive(:find_plottable).with(plottable_key)
        chart_builder.plot plottable_key
      end

      it 'creates a plottable with the options merged into the plottable options' do
        plottable.stub(options: {some: 'options', other: 'options'})
        Quby::Questionnaires::Entities::Charting::Plottable.should_receive(:new)
          .with(plottable.key,
                some: 'different_options',
                other: 'options',
                questionnaire_key: 'questionnaire_key')
        chart_builder.plot plottable_key, some: 'different_options'
      end

      it 'sets the label from a question title when no label is present' do
        plottable = Quby::Questionnaires::Entities::Question.new plottable_key, title: 'some_title'
        questionnaire.stub(:find_plottable).with(plottable_key).and_return plottable
        Quby::Questionnaires::Entities::Charting::Plottable.should_receive(:new)
          .with(plottable_key, questionnaire_key: 'questionnaire_key', label: 'some_title')
        chart_builder.plot plottable_key
      end

      it 'does not set the label when it is given in the options' do
        plottable = Quby::Questionnaires::Entities::Question.new plottable_key, title: 'some_title'
        questionnaire.stub(:find_plottable).with(plottable_key).and_return plottable
        Quby::Questionnaires::Entities::Charting::Plottable.should_receive(:new)
          .with(plottable_key, questionnaire_key: 'questionnaire_key', label: 'some_label')
        chart_builder.plot plottable_key, label: 'some_label'
      end
    end

    describe '#y_categories' do
      it 'assigns y_categories' do
        categories = %w(Bad Great Best)
        chart_builder.y_categories categories
        expect(chart_builder.build { }.y_categories).to eq(categories)
      end
    end

    describe '#y_range_categories' do
      it 'assigns y_range_categories' do
        expected_categories = {(0.0...30.0) => "Zeer laag", (30.0...40.0) => "Laag", (40.0...60.0) => "Gemiddeld",
                               (60.0...70.0) => "Hoog", (70.0..100.0) => "Zeer hoog"}
        chart_builder.y_range_categories 0, 'Zeer laag',
                                         30, 'Laag',
                                         40, 'Gemiddeld',
                                         60, 'Hoog',
                                         70, 'Zeer hoog', 100
        expect(chart_builder.build { }.y_range_categories).to eq(expected_categories)
      end

      it 'works for a single range' do
        expected_categories = {(0.0..100.0) => "Zeer hoog"}
        chart_builder.y_range_categories 0, 'Zeer hoog', 100

        expect(chart_builder.build { }.y_range_categories).to eq(expected_categories)
      end

      it 'rejects single values and even numbers of parameters' do
        expected = "chart_key y_range_categories should be of the form (0, 'label 0-10', 10, 'label 10-20', 20)"
        expect { chart_builder.y_range_categories 0 }.to raise_exception(expected)
        expect { chart_builder.y_range_categories 0, 'label', 10, 'lobel' }.to raise_exception(expected)
      end
    end

    describe '#range' do
      it 'assigns y_range' do
        chart_builder.range 0..5
        expect(chart_builder.build { }.y_range).to eq(0..5)
      end
    end
    describe '#validate' do
      describe 'when there is no range defined but y_categories are present' do
        it 'uses the 0..y_categories.count-1 as a range' do
          chart_builder.y_categories %w(Bad Great Best)
          expect(chart_builder.build { }.y_range).to eq(0..2)
        end
      end
      describe 'when range and y_categories are present' do
        it 'raises if the range does not correspond to the y_categories length' do
          chart_builder.range 0..3
          chart_builder.y_categories %w(Bad Great Best)
          expect { chart_builder.build { } }.to raise_error(ArgumentError)
        end
        it 'does not raise if the range matches the y_categories' do
          chart_builder.range 0..2
          chart_builder.y_categories %w(Bad Great Best)
          expect { chart_builder.build { } }.not_to raise_error
        end
      end
    end
  end
end

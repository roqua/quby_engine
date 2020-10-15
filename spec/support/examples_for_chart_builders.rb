# frozen_string_literal: true

require 'spec_helper'

shared_examples_for Quby::Questionnaires::DSL::ChartBuilder do
  let(:questionnaire) { double(key: 'honos') }

  it 'sets title' do
   expect(dsl { title 'Totaalscore' }.title).to eq "Totaalscore"
  end

  it 'sets chart type' do
    expect(dsl { chart_type :bar }.chart_type).to eq :bar
  end

  describe 'setting which scores & answers should be included in the chart' do
    let(:tot_score) { Quby::Questionnaires::Entities::ScoreCalculation.new :tot, label: 'Totaal' }
    let(:soc_score) { Quby::Questionnaires::Entities::ScoreCalculation.new :soc, label: 'Sociaal' }
    let(:float_question) { double(key: :v_1, type: :radio, options: []) }

    let(:plotted_tot_score) do
      Quby::Questionnaires::Entities::Charting::Plottable.new(:tot, label: 'Totaal',       questionnaire_key: 'honos')
    end

    let(:plotted_soc_score) do
      Quby::Questionnaires::Entities::Charting::Plottable.new(:soc, label: 'Sociaal',      questionnaire_key: 'honos')
    end

    let(:plotted_question) do
      Quby::Questionnaires::Entities::Charting::Plottable.new(:v_1, label: 'Answer Label', questionnaire_key: 'honos')
    end

    before do
      allow(questionnaire).to receive(:find_plottable).with(:tot).and_return(tot_score)
      allow(questionnaire).to receive(:find_plottable).with(:soc).and_return(soc_score)
      allow(questionnaire).to receive(:find_plottable).with('v_1').and_return(float_question)
    end

    it 'can be done by passing score keys individually' do
      expect(dsl { plot :tot; plot :soc }.plottables).to eq [plotted_tot_score, plotted_soc_score]
    end

    it 'can specify which item from the score hash to plot' do
      plottable = Quby::Questionnaires::Entities::Charting::Plottable.new(:tot, label: 'Totaal',
                                                                                plotted_key: :t_score,
                                                                                questionnaire_key: 'honos')
      expect(dsl { plot :tot, plotted_key: :t_score }.plottables).to eq [plottable]
    end

    it 'raises when adding score that references unknown scores or questions' do
      allow(questionnaire).to receive(:find_plottable).with(:tot).and_return(nil)
      expect { dsl { plot :tot } }.to raise_error(/references unknown score/)
    end

    it 'can plot answers' do
      expect(dsl { plot 'v_1', label: 'Answer Label' }.plottables).to eq [plotted_question]
    end
  end
end

shared_examples_for Quby::Compiler::DSL::ChartBuilder do
  let(:questionnaire) { double(key: 'honos') }

  it 'sets title' do
   expect(dsl { title 'Totaalscore' }.title).to eq "Totaalscore"
  end

  it 'sets chart type' do
    expect(dsl { chart_type :bar }.chart_type).to eq :bar
  end

  describe 'setting which scores & answers should be included in the chart' do
    let(:tot_score) { Quby::Compiler::Entities::ScoreCalculation.new :tot, label: 'Totaal' }
    let(:soc_score) { Quby::Compiler::Entities::ScoreCalculation.new :soc, label: 'Sociaal' }
    let(:float_question) { double(key: :v_1, type: :radio, options: []) }

    let(:plotted_tot_score) do
      Quby::Compiler::Entities::Charting::Plottable.new(:tot, label: 'Totaal',       questionnaire_key: 'honos')
    end

    let(:plotted_soc_score) do
      Quby::Compiler::Entities::Charting::Plottable.new(:soc, label: 'Sociaal',      questionnaire_key: 'honos')
    end

    let(:plotted_question) do
      Quby::Compiler::Entities::Charting::Plottable.new(:v_1, label: 'Answer Label', questionnaire_key: 'honos')
    end

    before do
      allow(questionnaire).to receive(:find_plottable).with(:tot).and_return(tot_score)
      allow(questionnaire).to receive(:find_plottable).with(:soc).and_return(soc_score)
      allow(questionnaire).to receive(:find_plottable).with('v_1').and_return(float_question)
    end

    it 'can be done by passing score keys individually' do
      expect(dsl { plot :tot; plot :soc }.plottables).to eq [plotted_tot_score, plotted_soc_score]
    end

    it 'can specify which item from the score hash to plot' do
      plottable = Quby::Compiler::Entities::Charting::Plottable.new(:tot, label: 'Totaal',
                                                                                plotted_key: :t_score,
                                                                                questionnaire_key: 'honos')
      expect(dsl { plot :tot, plotted_key: :t_score }.plottables).to eq [plottable]
    end

    it 'raises when adding score that references unknown scores or questions' do
      allow(questionnaire).to receive(:find_plottable).with(:tot).and_return(nil)
      expect { dsl { plot :tot } }.to raise_error(/references unknown score/)
    end

    it 'can plot answers' do
      expect(dsl { plot 'v_1', label: 'Answer Label' }.plottables).to eq [plotted_question]
    end
  end
end

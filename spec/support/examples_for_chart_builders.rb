require 'spec_helper'

shared_examples_for Quby::Questionnaires::DSL::ChartBuilder do
  let(:questionnaire) { double(key: 'honos') }

  it 'sets title' do
    dsl { title 'Totaalscore' }.title.should == "Totaalscore"
  end

  it 'sets chart type' do
    dsl { chart_type :bar }.chart_type.should == :bar
  end

  describe 'setting which scores & answers should be included in the chart' do
    let(:tot_score) { Quby::Questionnaires::Entities::ScoreCalculation.new :tot, label: 'Totaal' }
    let(:soc_score) { Quby::Questionnaires::Entities::ScoreCalculation.new :soc, label: 'Sociaal' }
    let(:float_question) { double(key: :v_1, type: :radio, options: []) }
    let(:plotted_tot_score) { Quby::Questionnaires::Entities::Charting::Plottable.new(:tot, label: 'Totaal',       questionnaire_key: 'honos') }
    let(:plotted_soc_score) { Quby::Questionnaires::Entities::Charting::Plottable.new(:soc, label: 'Sociaal',      questionnaire_key: 'honos') }
    let(:plotted_question)  { Quby::Questionnaires::Entities::Charting::Plottable.new(:v_1, label: 'Answer Label', questionnaire_key: 'honos') }

    before do
      questionnaire.stub(:find_plottable).with(:tot).and_return(tot_score)
      questionnaire.stub(:find_plottable).with(:soc).and_return(soc_score)
      questionnaire.stub(:find_plottable).with('v_1').and_return(float_question)
    end

    it 'can be done by passing score keys individually' do
      dsl { plot :tot; plot :soc }.plottables.should == [plotted_tot_score, plotted_soc_score]
    end

    it 'can specify which item from the score hash to plot' do
      plottable = Quby::Questionnaires::Entities::Charting::Plottable.new(:tot, label: 'Totaal',
                                                      plotted_key: :t_score,
                                                      questionnaire_key: 'honos')
      dsl { plot :tot, plotted_key: :t_score }.plottables.should == [plottable]
    end

    it 'raises when adding score that references unknown scores or questions' do
      questionnaire.stub(:find_plottable).with(:tot).and_return nil
      expect { dsl { plot :tot } }.to raise_error(/references unknown score/)
    end

    it 'can plot answers' do
      dsl { plot 'v_1', label: 'Answer Label' }.plottables.should == [plotted_question]
    end
  end
end

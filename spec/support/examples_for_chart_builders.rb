require 'spec_helper'
shared_examples_for Quby::QuestionnaireDsl::ChartBuilder do
  let(:questionnaire) { stub(key: 'questionnaire_key') }

  it 'sets title' do
    dsl { title 'Totaalscore' }.title.should == "Totaalscore"
  end

  it 'sets chart type' do
    dsl { chart_type :bar }.chart_type.should == :bar
  end

  describe 'setting which scores & answers should be included in the chart' do
    let(:tot_score) { stub(key: :tot, label: 'Totaal') }
    let(:soc_score) { stub(key: :soc, label: 'Sociaal') }
    let(:float_question) { stub(:key => :v_1, :type => :float) }
    let(:plotted_tot_score) { Quby::Charting::Plottable.new(:tot, label: 'Totaal') }
    let(:plotted_soc_score) { Quby::Charting::Plottable.new(:soc, label: 'Sociaal') }
    let(:plotted_question)  { Quby::Charting::Plottable.new(:v_1, label: 'Answer Label')}

    before do
      questionnaire.stub(:find_plottable).with(:tot).and_return(tot_score)
      questionnaire.stub(:find_plottable).with(:soc).and_return(soc_score)
      questionnaire.stub(:find_plottable).with('v_1').and_return(float_question)
    end

    it 'can be done by passing score keys individually' do
      dsl { plot :tot; plot :soc }.plottables.should == [plotted_tot_score, plotted_soc_score]
    end

    it 'can specify which item from the score hash to plot' do
      plottable = Quby::Charting::Plottable.new(:tot, label: 'Totaal', plotted_key: :t_score)
      dsl { plot :tot, :t_score }.plottables.should == [plottable]
    end

    it 'raises when adding score that references unknown scores or questions' do
      questionnaire.stub(:find_plottable).with(:tot).and_return nil
      expect { dsl { plot :tot } }.to raise_error(/references unknown score/)
    end

    it 'can plot answers' do
      dsl {
        plot 'v_1', :value, :label => 'Answer Label'
      }.plottables.should == [plotted_question]
    end
  end
end
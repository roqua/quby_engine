require 'spec_helper'

module Quby
  module QuestionnaireDsl
    describe LineChartBuilder do
      let(:questionnaire) { stub }

      it 'makes a line chart' do
        dsl { }.should be_an_instance_of(::Quby::Charting::LineChart)
      end

      it 'sets title' do
        dsl { title 'Totaalscore' }.title.should == "Totaalscore"
      end

      it 'sets chart type' do
        dsl { chart_type :bar }.chart_type.should == :bar
      end

      it 'sets score_sub_key' do
        dsl { score_sub_key :perc }.score_sub_key.should == :perc
      end

      it 'sets y-axis label' do
        dsl { y_axis_label 'Label' }.y_label.should == 'Label'
      end

      it 'sets y-axis range' do
        dsl { range 0..40 }.y_range.should == (0..40)
      end

      it 'sets y-axis stepsize' do
        dsl { stepsize 4 }.y_stepsize.should == 4.0
      end

      it 'sets tonality' do
        dsl { tonality :higher_is_better }.tonality.should == :higher_is_better
      end

      it 'sets baseline' do
        dsl { baseline 5 }.baseline.should == 5.0
      end

      it 'sets clinically relevant change' do
        dsl { clinically_relevant_change 5 }.clinically_relevant_change.should == 5.0
      end

      it 'sets scores' do
        tot_score = stub(key: :tot, label: 'Totaal')
        soc_score = stub(key: :soc, label: 'Sociaal')
        questionnaire.stub(:find_score).with(:tot).and_return(tot_score)
        questionnaire.stub(:find_score).with(:soc).and_return(soc_score)
        dsl { scores :tot, :soc }.scores.should == [tot_score, soc_score]
      end

      it 'raises when adding score that references unknown scores' do
        questionnaire.stub(:find_score).with(:tot).and_return(nil)
        expect { dsl(){ scores :tot } }.to raise_error(/references unknown scores/)
      end

      def dsl(key = :test, options = {}, &block)
        builder = LineChartBuilder.new(questionnaire, key, options)
        builder.build(&block)
      end
    end
  end
end

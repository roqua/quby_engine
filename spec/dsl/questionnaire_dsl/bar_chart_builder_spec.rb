require 'spec_helper'

module Quby
  module QuestionnaireDsl
    describe BarChartBuilder do
      let(:questionnaire) { stub(key: 'questionnaire_key') }

      it 'makes a bar chart' do
        dsl { }.should be_an_instance_of(::Quby::Charting::BarChart)
      end

      it 'sets title' do
        dsl { title 'Totaalscore' }.title.should == "Totaalscore"
      end

      describe 'setting which scores should be included in the chart' do
        let(:tot_score) { stub(key: :tot, label: 'Totaal') }
        let(:soc_score) { stub(key: :soc, label: 'Sociaal') }
        let(:plotted_tot_score) { Quby::Charting::PlottedScore.new(:tot, label: 'Totaal') }
        let(:plotted_soc_score) { Quby::Charting::PlottedScore.new(:soc, label: 'Sociaal') }

        before do
          questionnaire.stub(:find_score).with(:tot).and_return(tot_score)
          questionnaire.stub(:find_score).with(:soc).and_return(soc_score)
        end

        it 'can be done by passing score keys individually' do
          dsl { plot :tot; plot :soc }.scores.should == [plotted_tot_score, plotted_soc_score]
        end

        it 'can specify which item from the score hash to plot' do
          plotted_score = Quby::Charting::PlottedScore.new(:tot, label: 'Totaal', plotted_key: :t_score)
          dsl { plot :tot, :t_score }.scores.should == [plotted_score]
        end

        it 'raises when adding score that references unknown scores' do
          questionnaire.stub(:find_score).with(:tot) { raise KeyError }
          expect { dsl { plot :tot } }.to raise_error(/references unknown score/)
        end
      end

      def dsl(key = :test, options = {}, &block)
        builder = BarChartBuilder.new(questionnaire, key, options)
        builder.build(&block)
      end
    end
  end
end

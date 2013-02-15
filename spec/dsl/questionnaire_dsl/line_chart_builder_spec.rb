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

      it 'sets baseline to constant value' do
        dsl { baseline 5 }.baseline.call(1, :male).should == 5.0
      end

      it 'sets baseline to proc' do
        dsl { baseline {|age, gender| age } }.baseline.call(5, :male).should == 5.0
        expect { dsl { baseline {|age| age } } }.to raise_error(ArgumentError, /must take two arguments/)
      end

      it 'raises error if not giving baseline value or block' do
        expect { dsl { baseline } }.to raise_error(ArgumentError, /either value or a block/)
        expect { dsl { baseline(5.0) {|age, gender| age } } }.to raise_error(ArgumentError, /either value or a block/)
      end

      it 'sets clinically relevant change' do
        dsl { clinically_relevant_change 5 }.clinically_relevant_change.should == 5.0
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
          questionnaire.stub(:find_score).with(:tot).and_return(nil)
          expect { dsl { plot :tot } }.to raise_error(/references unknown score/)
        end
      end

      def dsl(key = :test, options = {}, &block)
        builder = LineChartBuilder.new(questionnaire, key, options)
        builder.build(&block)
      end
    end
  end
end

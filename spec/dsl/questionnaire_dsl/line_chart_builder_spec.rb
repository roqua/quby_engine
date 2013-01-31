require 'spec_helper'

module Quby
  module QuestionnaireDsl
    describe LineChartBuilder do
      it 'makes a line chart' do
        dsl { }.should be_an_instance_of(::Quby::Charting::LineChart)
      end

      it 'sets title' do
        dsl { title 'Totaalscore' }.title.should == "Totaalscore"
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

      def dsl(key = :test, options = {}, &block)
        builder = LineChartBuilder.new(key, options)
        builder.build(&block)
      end
    end
  end
end

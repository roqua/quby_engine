require 'spec_helper'

module Quby
  module QuestionnaireDsl
    describe BarChartBuilder do
      let(:questionnaire) { stub }

      it 'makes a bar chart' do
        dsl { }.should be_an_instance_of(::Quby::Charting::BarChart)
      end

      it 'sets title' do
        dsl { title 'Totaalscore' }.title.should == "Totaalscore"
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
        builder = BarChartBuilder.new(questionnaire, key, options)
        builder.build(&block)
      end
    end
  end
end

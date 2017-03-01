require 'spec_helper'

module Quby::Questionnaires::Entities
  module Charting
    describe Plottable do
      it 'stores the key' do
        score = Plottable.new(:tot)
        score.key.should == :tot
      end

      it 'stores the questionnaire_key' do
        score = Plottable.new(:tot, questionnaire_key: 'qkey')
        score.questionnaire_key.should == 'qkey'
      end

      it 'stores the label' do
        score = Plottable.new(:tot, label: 'Label')
        score.label.should == 'Label'
      end

      it 'has a default plotted key' do
        Plottable.new(:tot).plotted_key.should == :value
      end

      it 'stores the plotted key' do
        score = Plottable.new(:tot, plotted_key: :tscore)
        score.plotted_key.should == :tscore
      end

      it 'stores a global flag' do
        score = Plottable.new(:tot, global: true)
        score.global.should be_truthy
      end
    end
  end
end

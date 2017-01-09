require 'spec_helper'

module Quby::Questionnaires::Entities
  describe ScoreCalculation do
    let(:calculation) { proc { 1 } }
    subject { ScoreCalculation.new(:tot, label: "Totaal", &calculation) }

    it { subject.key.should == :tot }
    it { subject.label.should == "Totaal" }
    it { subject.calculation.should == calculation }

    context 'when not given any options' do
      subject { ScoreCalculation.new(:tot, {}, &calculation) }
      it { subject.label.should be_nil }
    end

    context 'when having a score option set to true' do
      subject { ScoreCalculation.new(:tot, {score: true}, &calculation) }
      it { subject.score.should be_true }
    end
    context 'when having an action option set to true' do
      subject { ScoreCalculation.new(:tot, {action: true}, &calculation) }
      it { subject.action.should be_true }
    end
    context 'when having a completion option set to true' do
      subject { ScoreCalculation.new(:tot, {completion: true}, &calculation) }
      it { subject.completion.should be_true }
    end
  end
end

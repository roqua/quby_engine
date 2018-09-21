# frozen_string_literal: true

require 'spec_helper'

module Quby::Questionnaires::Entities
  describe ScoreCalculation do
    let(:calculation) { proc { 1 } }
    subject { ScoreCalculation.new(:tot, label: "Totaal", sbg_key: 'TOT', &calculation) }

    it { subject.key.should == :tot }
    it { subject.label.should == "Totaal" }
    it { subject.sbg_key.should == "TOT" }
    it { subject.calculation.should == calculation }

    context 'when not given any options' do
      subject { ScoreCalculation.new(:tot, {}, &calculation) }
      it { subject.label.should be_nil }
      it { subject.sbg_key.should be_nil }
    end

    context 'when having a score option set to true' do
      subject { ScoreCalculation.new(:tot, {score: true}, &calculation) }
      it { subject.score.should be_truthy }
    end
    context 'when having an action option set to true' do
      subject { ScoreCalculation.new(:tot, {action: true}, &calculation) }
      it { subject.action.should be_truthy }
    end
    context 'when having a completion option set to true' do
      subject { ScoreCalculation.new(:tot, {completion: true}, &calculation) }
      it { subject.completion.should be_truthy }
    end
  end
end

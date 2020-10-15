# frozen_string_literal: true

require 'spec_helper'

module Quby::Compiler::Entities
  describe ScoreCalculation do
    let(:calculation) { proc { 1 } }
    subject { ScoreCalculation.new(:tot, label: "Totaal", sbg_key: 'TOT', &calculation) }

    it { expect(subject.key).to eq :tot }
    it { expect(subject.label).to eq "Totaal" }
    it { expect(subject.sbg_key).to eq "TOT" }
    it { expect(subject.calculation).to eq calculation }

    context 'when not given any options' do
      subject { ScoreCalculation.new(:tot, {}, &calculation) }
      it { expect(subject.label).to be_nil }
      it { expect(subject.sbg_key).to be_nil }
    end

    context 'when having a score option set to true' do
      subject { ScoreCalculation.new(:tot, {score: true}, &calculation) }
      it { expect(subject.score).to be_truthy }
    end
    context 'when having an action option set to true' do
      subject { ScoreCalculation.new(:tot, {action: true}, &calculation) }
      it { expect(subject.action).to be_truthy }
    end
    context 'when having a completion option set to true' do
      subject { ScoreCalculation.new(:tot, {completion: true}, &calculation) }
      it { expect(subject.completion).to be_truthy }
    end
  end
end

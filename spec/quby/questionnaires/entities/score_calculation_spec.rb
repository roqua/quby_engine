require 'spec_helper'

module Quby::Questionnaires::Entities
  describe ScoreCalculation do
    let(:calculation) { proc { 1 } }
    subject { ScoreCalculation.new(:totaal_key, label: "Totaal", &calculation) }

    its(:key) { should == :totaal_key }
    its(:label) { should == "Totaal" }
    its(:calculation) { should == calculation }

    context 'when a short_key is not given it should default to the first (8) chars of key' do
      its(:short_key) { should == "tota" }
    end

    context 'when not given any options' do
      subject { ScoreCalculation.new(:totaal_key, {}, &calculation) }
      its(:label) { should be_nil }
    end

    context 'when having a score option set to true' do
      subject { ScoreCalculation.new(:totaal_key, {score: true}, &calculation) }
      its(:score) { should be_true }
    end
    context 'when having an action option set to true' do
      subject { ScoreCalculation.new(:totaal_key, {action: true}, &calculation) }
      its(:action) { should be_true }
    end
    context 'when having a completion option set to true' do
      subject { ScoreCalculation.new(:totaal_key, {completion: true}, &calculation) }
      its(:completion) { should be_true }
    end
  end
end

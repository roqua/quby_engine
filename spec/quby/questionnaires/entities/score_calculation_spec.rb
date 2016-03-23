require 'spec_helper'

module Quby::Questionnaires::Entities
  describe ScoreCalculation do
    let(:calculation) { proc { 1 } }
    subject { ScoreCalculation.new(:tot, label: "Totaal", &calculation) }

    its(:key) { should == :tot }
    its(:label) { should == "Totaal" }
    its(:calculation) { should == calculation }

    context 'when not given any options' do
      subject { ScoreCalculation.new(:tot, {}, &calculation) }
      its(:label) { should be_nil }
    end

    context 'when having a score option set to true' do
      subject { ScoreCalculation.new(:tot, {score: true}, &calculation) }
      its(:score) { should be_truthy }
    end
    context 'when having an action option set to true' do
      subject { ScoreCalculation.new(:tot, {action: true}, &calculation) }
      its(:action) { should be_truthy }
    end
    context 'when having a completion option set to true' do
      subject { ScoreCalculation.new(:tot, {completion: true}, &calculation) }
      its(:completion) { should be_truthy }
    end
  end
end

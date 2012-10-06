require 'spec_helper'

module Quby
  describe Score do
    let(:calculation) { Proc.new { 1 } }
    subject { Score.new(:tot, label: "Totaal", &calculation) }

    its(:key) { should == :tot }
    its(:label) { should == "Totaal" }
    its(:calculation) { should == calculation }

    context 'when not given any options' do
      subject { Score.new(:tot, {}, &calculation) }
      its(:label) { should be_nil }
    end
  end
end
require 'spec_helper'

module Quby
  describe ScoreCalculations do
    describe '#calculate_scores' do
      let(:scorer) { Proc.new { 3 } }
      let(:score) { stub(:key => :tot, :scorer => scorer) }
      let(:scores) { [score] }
      let(:questionnaire) { stub(:scores => scores, :questions => []) }

      before do
        Answer.any_instance.stub(:questionnaire => questionnaire)
      end

      it 'calculates scores' do
        score.stub(:scorer => Proc.new { 3 })
        answer = Answer.new(value: {})
        answer.calculate_scores.should == {:tot => 3}
      end

      it 'calculates scores with integer values' do
        score.stub(:scorer => Proc.new { values(:v1) })
        questionnaire.stub(:questions => [stub(:key => :v1, 
                                               :type => :radio, 
                                               :options => [
                                                 stub(:key => :a1, :value => 2)
                                                 ],
                                               :text_var => false)])
        answer = Answer.new(value: {'v1' => :a1})
        answer.calculate_scores.should == {:tot => [2]}
      end
    end
  end
end

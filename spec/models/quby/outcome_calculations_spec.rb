require 'spec_helper'

module Quby
  describe OutcomeCalculations do
    let(:scorer) { Proc.new { 3 } }
    let(:score) { Score.new(:tot, {label: "Totaal"}, &scorer) }
    let(:scores) { [score] }

    let(:actioner) { Proc.new { 5} }
    let(:action) { stub(:key => 'attention', :calculation => actioner) }
    let(:actions) { [action] }

    let(:questionnaire) { stub(:scores => scores,
                               :actions => actions,
                               :questions => [], :last_update => Time.now, :key => nil) }
    let(:answer) { Answer.new }

    before do
      Answer.any_instance.stub(:questionnaire => questionnaire)
    end

    describe '#action' do
      it 'returns :alarm if any score is alarming' do
        answer.scores = {tot: {label: "Totaal", value: 10, status: "alarm"},
                         soc: {label: "Sociaal", value: 5, status: "attention"}}
        answer.action.should == :alarm
      end

      it 'returns :alarm if an answer to a question is alarming' do
        answer.actions = {alarm: [:v_1]}
        answer.action.should == :alarm
      end

      it 'returns :attention if nothing is alarming and score is attention-worthy' do
        answer.scores = {tot: {label: 'Totaal', value: 10, status: "attention"}}
        answer.action.should == :attention
      end

      it 'returns :attention if nothing is alarming and an answer to a question is attention-worthy' do
        answer.actions = {alarm: [], attention: [:v_1]}
        answer.action.should == :attention
      end

      it 'returns nil if all scores and answers are neither alarming nor attention-worthy' do
        answer.scores = {tot: {label: 'Totaal', value: 10}}
        answer.actions = {alarm: [], attention: []}
        answer.action.should be_nil
      end

      it 'works with symbols as well as keys for score statusses' do
        answer.scores = {tot: {label: "Totaal", value: 10, status: :alarm},
                         soc: {label: "Sociaal", value: 5, status: "attention"}}
        answer.action.should == :alarm
      end
    end

    describe '#calculate_scores' do
      it 'calculates scores' do
        score.stub(:calculation => Proc.new { 3 })
        answer.calculate_scores.should == {:tot => 3}
      end

      it 'calculates scores with integer values' do
        score.stub(:calculation => Proc.new { values(:v1) })
        questionnaire.stub(:questions => [stub(:key => :v1,
                                               :type => :radio,
                                               :options => [
                                                 stub(:key => :a1, :value => 2)
                                                 ],
                                               :text_var => false)])
        answer.value = {'v1' => :a1}
        answer.calculate_scores.should == {:tot => [2]}
      end

      it 'allows access to other scores' do
        score1 = stub(key: :one, calculation: Proc.new { {value: 4} })
        score2 = stub(key: :two, calculation: Proc.new { {value: score(:one)[:value] + 2} })
        scores = [score1, score2]
        questionnaire.stub(scores: scores)
        answer.calculate_scores.should == {one: {value: 4}, two: {value: 6}}
      end

      context 'when calculation throws an exception' do
        before { score.stub(:calculation => Proc.new { raise "Foo" }) }

        it 'stores the exception' do
          answer.calculate_scores[:tot][:exception].should == 'Foo'
        end

        it 'includes the label' do
          answer.calculate_scores[:tot][:label].should == "Totaal"
        end
      end
    end

    describe '#update_scores' do
      it 'calculates scores' do
        answer.should_receive(:calculate_scores)
        answer.should_receive(:calculate_actions)
        answer.update_scores
      end

      it 'assigns the calculated score to self.scores' do
        answer.update_scores
        answer.scores.should == {'tot' => 3}
      end

      it 'assigns the calculated actions to self.actions' do
        answer.update_scores
        answer.actions.should == {'attention' => 5}
      end

      it 'skips the set_score callback' do
        answer.update_scores
        answer.should_not_receive(:set_scores)
      end

      it 'skips the set_actions callback' do
        answer.update_scores
        answer.should_not_receive(:set_actions)
      end
    end
  end
end

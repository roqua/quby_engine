require 'spec_helper'

module Quby
  describe OutcomeCalculations do
    let(:scorer) { proc { {value: 3} } }
    let(:score) { Score.new(:tot, {label: "Totaal", score: true}, &scorer) }

    let(:actioner) { proc { 5 } }
    let(:action) { Score.new(:attention, {action: true}, &actioner) }

    let(:completioner) { proc { 0.9 } }
    let(:completion) { Score.new(:completion, {completion: true}, &completioner) }

    let(:questionnaire) do
      quest = Questionnaire.new "test"

      quest.push_score_builder score
      quest.push_score_builder action
      quest.push_score_builder completion

      quest.stub(questions: [], last_update: Time.now, key: nil)
      quest
    end
    let(:answer) { Answer.new }

    before do
      Answer.any_instance.stub(questionnaire: questionnaire)
    end

    describe '#action' do
      it 'returns :alarm if any score is alarming' do
        answer.scores = {tot: {label: "Totaal", value: 10, status: "alarm"},
                         soc: {label: "Sociaal", value: 5, status: "attention"}}
        answer.action.should eq :alarm
      end

      it 'returns :alarm if an answer to a question is alarming' do
        answer.actions = {alarm: [:v_1]}
        answer.action.should eq :alarm
      end

      it 'returns :attention if nothing is alarming and score is attention-worthy' do
        answer.scores = {tot: {label: 'Totaal', value: 10, status: "attention"}}
        answer.action.should eq :attention
      end

      it 'returns :attention if nothing is alarming and an answer to a question is attention-worthy' do
        answer.actions = {alarm: [], attention: [:v_1]}
        answer.action.should eq :attention
      end

      it 'returns nil if all scores and answers are neither alarming nor attention-worthy' do
        answer.scores = {tot: {label: 'Totaal', value: 10}}
        answer.actions = {alarm: [], attention: []}
        answer.action.should be_nil
      end

      it 'works with symbols as well as keys for score statusses' do
        answer.scores = {tot: {label: "Totaal", value: 10, status: :alarm},
                         soc: {label: "Sociaal", value: 5, status: "attention"}}
        answer.action.should eq :alarm
      end
    end

    describe '#calculate_builders' do
      it 'passes in the regular values and completed_at to the score calculator' do
        answer.stub(value_by_regular_values: 'regular_values',
                    completed_at: 'completed_at')
        ScoreCalculator.stub :calculate
        ScoreCalculator.should_receive(:calculate).with('regular_values', 'completed_at', {}, {})
        answer.calculate_builders
      end

      it 'calculates scores, alerts and completion' do
        answer.calculate_builders

        answer.scores.should eq( "tot" => {"value" => 3, "label" => "Totaal", "score" => true})
        answer.actions.should eq("attention" => 5)
        answer.completion.should eq("value" => 0.9)
      end

      it 'calculates scores with integer values' do
        score.stub(calculation: proc { {value: values(:v1)} })
        questionnaire.stub(questions: [double(key: :v1,
                                              type: :radio,
                                              options: [
                                                double(key: :a1, value: 2)
                                              ],
                                              text_var: false)])
        answer.value = {'v1' => :a1}
        answer.tap(&:calculate_builders).scores[:tot].should eq("value" => [2], "label" => "Totaal", "score" => true)
      end

      it 'allows access to other scores' do
        score2 = Score.new(:tot2, {label: "Totaal2", score: true}, &proc { {value: score(:tot)[:value] + 2} })

        questionnaire.push_score_builder score2
        answer.tap(&:calculate_builders).scores[:tot2].should eq("value" => 5, "label" => "Totaal2", "score" => true)
      end

      context 'when calculation throws an exception' do
        before { score.stub(calculation: proc { raise "Foo" }) }

        it 'stores the exception' do
          answer.tap(&:calculate_builders).scores[:tot][:exception].should eq 'Foo'
        end

        it 'includes the label' do
          answer.tap(&:calculate_builders).scores[:tot][:label].should eq "Totaal"
        end
      end

      it 'calculates completion percentage' do
        completion.stub(calculation: proc { 0.9 })
        answer.tap(&:calculate_builders).completion.should eq('value' => 0.9)
      end

      it 'updates outcome generation timestamp' do
        Timecop.freeze do
          answer.tap(&:calculate_builders).outcome_generated_at.to_i.should eq Time.now.to_i
        end
      end

      context 'when calculation throws an exception' do
        it 'stores the exception' do
          completion.stub(calculation: proc { raise "Foo" })
          answer.tap(&:calculate_builders).completion[:exception].should eq 'Foo'
        end
      end

      context 'when questionnaire has no calculation' do
        it 'returns an empty hash' do
          questionnaire.score_builders.delete(:completion)
          answer.tap(&:calculate_builders).completion.should eq({})
        end
      end
    end

    describe '#update_scores' do
      it 'calculates scores' do
        answer.should_receive(:calculate_builders)
        answer.update_scores
      end

      it 'assigns the calculated score to self.scores' do
        answer.update_scores
        answer.scores.should eq("tot" => {"value" => 3, "label" => "Totaal", "score" => true})
      end

      it 'assigns the calculated actions to self.actions' do
        answer.update_scores
        answer.actions.should eq('attention' => 5)
      end

      it 'assigns the calculated completion to self.completion' do
        answer.update_scores
        answer.completion.should eq('value' => 0.9)
      end

      it 'saves reorderings of scores' do
        scorer1 = proc { {value: 1} }
        score1  = Score.new(:tot, {label: "Totaalscore", score: true}, &scorer1)
        scorer2 = proc { {value: 2} }
        score2  = Score.new(:sub, {label: "Subscore", score: true}, &scorer2)
        questionnaire.score_builders = {}
        questionnaire.push_score_builder score1
        questionnaire.push_score_builder score2
        answer.update_scores
        answer.scores.keys.should eq %w(tot sub)
        answer.reload.scores.keys.should eq %w(tot sub)

        questionnaire.score_builders = {}
        questionnaire.push_score_builder score2
        questionnaire.push_score_builder score1
        answer.update_scores
        answer.scores.keys.should eq %w(sub tot)
        answer.reload.scores.keys.should eq %w(sub tot)
      end
    end
  end
end

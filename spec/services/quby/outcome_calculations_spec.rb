require 'spec_helper'

module Quby
  describe OutcomeCalculations do
    let(:scorer) { proc { {value: 3} } }
    let(:score) { ScoreCalculation.new(:tot, {label: "Totaal", score: true}, &scorer) }

    let(:actioner) { proc { 5 } }
    let(:action) { ScoreCalculation.new(:attention, {action: true}, &actioner) }

    let(:completioner) { proc { 0.9 } }
    let(:completion) { ScoreCalculation.new(:completion, {completion: true}, &completioner) }

    let(:questionnaire) do
      quest = Questionnaire.new "test"

      quest.add_score_calculation score
      quest.add_score_calculation action
      quest.add_score_calculation completion

      quest.stub(questions: [], last_update: Time.now, key: 'test')
      quest
    end

    let(:answer) { Quby.answer_repo.create!('test') }

    before do
      Quby.questionnaire_finder.stub(find: questionnaire)
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

        answer.scores.should eq("tot" => {"value" => 3, "label" => "Totaal",
                                          "score" => true, 'referenced_values' => []})
        answer.actions.should eq("attention" => 5)
        answer.completion.should eq("value" => 0.9)
      end

      it 'calculates scores with integer values' do
        score.stub(calculation: proc { {value: values(:v_1)} })
        questionnaire.stub(questions: [double(key: :v_1,
                                              type: :radio,
                                              options: [
                                                double(key: :a1, value: 2)
                                              ],
                                              text_var: false)])
        answer.value = {'v_1' => :a1}
        answer.tap(&:calculate_builders).scores[:tot].should eq("value" => [2], "label" => "Totaal",
                                                                "score" => true, 'referenced_values' => ['v_1'])
      end

      it 'allows access to other scores' do
        score2 = ScoreCalculation.new(:tot2,
                                      {label: "Totaal2", score: true},
                                      &proc { {value: score(:tot)[:value] + 2} })

        questionnaire.add_score_calculation score2
        answer.tap(&:calculate_builders).scores[:tot2].should eq("value" => 5, "label" => "Totaal2",
                                                                 "score" => true, 'referenced_values' => [])
      end

      context 'when calculation throws an exception' do
        before { score.stub(calculation: proc { fail "Foo" }) }

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
          completion.stub(calculation: proc { fail "Foo" })
          answer.tap(&:calculate_builders).completion[:exception].should eq 'Foo'
        end
      end

      context 'when questionnaire has no calculation' do
        it 'returns an empty hash' do
          questionnaire.score_calculations.delete(:completion)
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
        answer.scores.should eq("tot" => {"value" => 3, "label" => "Totaal",
                                          "score" => true, 'referenced_values' => []})
      end

      it 'assigns the calculated actions to self.actions' do
        answer.update_scores
        answer.actions.should eq('attention' => 5)
      end

      it 'assigns the calculated completion to self.completion' do
        answer.update_scores
        answer.completion.should eq('value' => 0.9)
      end

    end
  end
end

require 'spec_helper'

module Quby::Answers::Services
  describe OutcomeCalculation do
    ScoreCalculation = Quby::Questionnaires::Entities::ScoreCalculation
    Questionnaire = Quby::Questionnaires::Entities::Questionnaire

    let(:scorer) { proc { { value: 3 } } }
    let(:score) { ScoreCalculation.new(:tot, { label: "Totaal", score: true }, &scorer) }

    let(:actioner) { proc { 5 } }
    let(:action) { ScoreCalculation.new(:attention, { action: true }, &actioner) }

    let(:completioner) { proc { 0.9 } }
    let(:completion) { ScoreCalculation.new(:completion, { completion: true }, &completioner) }

    let(:questionnaire) do
      quest = Questionnaire.new "test"

      quest.add_score_calculation score
      quest.add_score_calculation action
      quest.add_score_calculation completion

      quest.stub(questions: [], last_update: Time.now, key: 'test')
      quest
    end

    let(:answer) { Quby.answers.create!('test') }

    before do
      Quby.questionnaires.stub(find: questionnaire)
    end

    describe '#calculate' do
      it 'passes in the regular values and completed_at to the score calculator' do
        answer.stub(value_by_regular_values: { v_2: 2, v_1: 1 }, completed_at: 'completed_at')
        received_values, received_timestamp, received_patient_attrs = nil

        ScoreCalculator.should_receive(:calculate).exactly(3).times do |values, timestamp, patient_attrs, scores|
          received_values = values
          received_timestamp = timestamp
          received_patient_attrs = patient_attrs
        end

        OutcomeCalculation.new(answer).calculate

        received_values.to_a.should eq([[:v_2, 2], [:v_1, 1]])
        received_timestamp.should eq('completed_at')
        received_patient_attrs.should eq({ })
      end

      it 'calculates scores, alerts and completion' do
        outcome = OutcomeCalculation.new(answer).calculate

        outcome.scores.should eq("tot" => { "value" => 3, "label" => "Totaal",
                                            "score" => true, 'referenced_values' => [] })
        outcome.actions.should eq("attention" => 5)
        outcome.completion.should eq("value" => 0.9)
      end

      it 'calculates scores with integer values' do
        score.stub(calculation: proc { { value: values(:v_1) } })
        questionnaire.stub(questions: [double(key: :v_1,
                                              type: :radio,
                                              options: [
                                                  double(key: :a1, value: 2)
                                              ],
                                              text_var: false)])
        answer.value = { 'v_1' => :a1 }
        outcome = OutcomeCalculation.new(answer).calculate
        outcome.scores[:tot].should eq("value" => [2], "label" => "Totaal",
                                       "score" => true, 'referenced_values' => ['v_1'])
      end

      it 'allows access to other scores' do
        score2 = ScoreCalculation.new(:tot2, { label: "Totaal2", score: true },
                                      &proc { { value: score(:tot)[:value] + 2 } })

        questionnaire.add_score_calculation score2
        outcome = OutcomeCalculation.new(answer).calculate
        outcome.scores[:tot2].should eq("value" => 5, "label" => "Totaal2",
                                        "score" => true, 'referenced_values' => [])
      end

      context 'when calculation throws an exception' do
        before { score.stub(calculation: proc { fail "Foo" }) }

        it 'stores the exception' do
          outcome = OutcomeCalculation.new(answer).calculate
          outcome.scores[:tot][:exception].should eq 'Foo'
        end

        it 'includes the label' do
          outcome = OutcomeCalculation.new(answer).calculate
          outcome.scores[:tot][:label].should eq "Totaal"
        end
      end

      it 'calculates completion percentage' do
        completion.stub(calculation: proc { 0.9 })
        outcome = OutcomeCalculation.new(answer).calculate
        outcome.completion.should eq('value' => 0.9)
      end

      it 'updates outcome generation timestamp' do
        Timecop.freeze do
          outcome = OutcomeCalculation.new(answer).calculate
          outcome.generated_at.to_i.should eq Time.now.to_i
        end
      end

      context 'when calculation throws an exception' do
        it 'reports the exception' do
          exception = StandardError.new 'some error'
          completion.stub(calculation: proc { raise exception })
          expect(Roqua::Support::Errors).to receive(:report).with(exception, root_path: Rails.root.to_s)
          OutcomeCalculation.new(answer).calculate
        end

        it 'stores the exception' do
          completion.stub(calculation: proc { fail "Foo" })
          outcome = OutcomeCalculation.new(answer).calculate
          outcome.completion[:exception].should eq 'Foo'
        end
      end

      context 'when questionnaire has no calculation' do
        it 'returns an empty hash' do
          questionnaire.score_calculations.delete(:completion)
          outcome = OutcomeCalculation.new(answer).calculate
          outcome.completion.should eq({})
        end
      end
    end

    describe '#update_scores' do
      it 'calculates scores' do
        answer.should_receive(:scores=)
        answer.should_receive(:actions=)
        answer.should_receive(:completion=)
        OutcomeCalculation.new(answer).update_scores
      end

      it 'assigns the calculated score to self.scores' do
        OutcomeCalculation.new(answer).update_scores
        answer.scores.should eq("tot" => { "value" => 3, "label" => "Totaal",
                                           "score" => true, 'referenced_values' => [] })
      end

      it 'assigns the calculated actions to self.actions' do
        OutcomeCalculation.new(answer).update_scores
        answer.actions.should eq('attention' => 5)
      end

      it 'assigns the calculated completion to self.completion' do
        OutcomeCalculation.new(answer).update_scores
        answer.completion.should eq('value' => 0.9)
      end
    end

    describe '#value_by_regular_values' do
      it 'orders the regular values according to the questionnaire\'s question order' do
        questionnaire.stub_chain(:fields, :question_hash, :keys).and_return([:v_1, :v_2])
        answer.stub(value_by_regular_values: { v_2: 2, v_1: 1 }, completed_at: 'completed_at')
        expect(OutcomeCalculation.new(answer).send(:value_by_regular_values)).to eq(v_1: 1, v_2: 2)
      end
    end
  end
end

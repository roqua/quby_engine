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
      quest = inject_questionnaire "test", <<-END
        question :v_1, type: :radio do
          title 'Q1'
          option :a1, value: 2, description: '1'
        end
        question :v_2, type: :radio do
          title 'Q2'
          option :a1, value: 2, description: '1'
        end

        question :v_3, type: :radio do
          title 'Q3'
          option :a1, value: 2, description: '1'
        end
      END

      quest.add_score_calculation score
      quest.add_score_calculation action
      quest.add_score_calculation completion

      allow(quest).to receive(:questions).and_return []
      allow(quest).to receive(:last_update).and_return Time.now
      allow(quest).to receive(:key).and_return 'test'
      quest
    end

    let(:answer) { Quby.answers.create!('test') }

    before do
      allow(Quby.questionnaires).to receive(:find).and_return(questionnaire)
    end

    describe '#calculate' do
      it 'passes in the regular values and completed_at to the score calculator' do
        allow(answer).to receive(:value_by_regular_values).and_return({ v_2: 2, v_1: 1 })
        allow(answer).to receive(:completed_at).and_return('completed_at')
        received_values, received_timestamp, received_patient_attrs = nil

        expect(ScoreCalculator).to receive(:calculate)
                       .exactly(3).times do |questionnaire, values, timestamp, patient_attrs, scores|
          received_values = values
          received_timestamp = timestamp
          received_patient_attrs = patient_attrs
        end

        OutcomeCalculation.new(answer).calculate

        expect(received_values.to_a).to eq([[:v_2, 2], [:v_1, 1]])
        expect(received_timestamp).to eq('completed_at')
        expect(received_patient_attrs).to eq({ })
      end

      it 'calculates scores, alerts and completion' do
        outcome = OutcomeCalculation.new(answer).calculate

        expect(outcome.scores).to eq("tot" => { "value" => 3, "label" => "Totaal",
                                                "score" => true, 'referenced_values' => [] })
        expect(outcome.actions).to eq("attention" => 5)
        expect(outcome.completion).to eq("value" => 0.9)
      end

      it 'calculates scores with integer values' do
        allow(score).to receive(:calculation).and_return(proc { { value: values(:v_1) } })
        allow(questionnaire).to receive(:questions).and_return([double(key: :v_1,
                                                                       type: :radio,
                                                                       options: [
                                                                           double(key: :a1, value: 2)
                                                                       ],
                                                                       sets_textvar: nil)])

        answer.value = { 'v_1' => :a1 }
        outcome = OutcomeCalculation.new(answer).calculate
        expect(outcome.scores[:tot]).to eq("value" => [2], "label" => "Totaal",
                                           "score" => true, 'referenced_values' => ['v_1'])
      end

      it 'allows access to other scores' do
        score2 = ScoreCalculation.new(:tot2, { label: "Totaal2", score: true },
                                      &proc { { value: score(:tot)[:value] + 2 } })

        questionnaire.add_score_calculation score2
        outcome = OutcomeCalculation.new(answer).calculate
        expect(outcome.scores[:tot2]).to eq("value" => 5, "label" => "Totaal2",
                                            "score" => true, 'referenced_values' => [])
      end

      it 'does not report an error when the calculation returns nil' do
        allow(score).to receive(:calculation).and_return proc { nil }
        outcome = OutcomeCalculation.new(answer).calculate
        expect(outcome.scores[:tot][:exception]).not_to be
      end

      context 'when calculation misses some values' do
        before { expect(score).to receive(:calculation).and_return(proc { values(:v_unknown) }) }

        it 'records a missing score outcome' do
          outcome = OutcomeCalculation.new(answer).calculate
          expect(outcome.scores[:tot]).to eq('label' => 'Totaal', 'score' => true, 'missing_values' => ['v_unknown'])
        end
      end

      context 'when calculation throws an exception' do
        before { expect(score).to receive(:calculation).and_return(proc { fail "Foo" }) }

        it 'stores the exception' do
          outcome = OutcomeCalculation.new(answer).calculate
          expect(outcome.scores[:tot][:exception]).to eq 'Foo'
        end

        it 'includes the label' do
          outcome = OutcomeCalculation.new(answer).calculate
          expect(outcome.scores[:tot][:label]).to eq "Totaal"
        end
      end

      it 'calculates completion percentage' do
        allow(completion).to receive(:calculation).and_return(proc { 0.9 })
        outcome = OutcomeCalculation.new(answer).calculate
        expect(outcome.completion).to eq('value' => 0.9)
      end

      it 'updates outcome generation timestamp' do
        Timecop.freeze do
          outcome = OutcomeCalculation.new(answer).calculate
          expect(outcome.generated_at.to_i).to eq Time.now.to_i
        end
      end

      context 'when calculation throws an exception' do
        it 'reports the exception' do
          exception = StandardError.new 'some error'
          allow(completion).to receive(:calculation).and_return(proc { fail exception })
          expect(Roqua::Support::Errors).to receive(:report).with(exception, root_path: Rails.root.to_s)
          OutcomeCalculation.new(answer).calculate
        end

        it 'stores the exception' do
          allow(completion).to receive(:calculation).and_return(proc { fail "Foo" })
          outcome = OutcomeCalculation.new(answer).calculate
          expect(outcome.completion[:exception]).to eq 'Foo'
        end
      end

      context 'when questionnaire has no calculation' do
        it 'returns an empty hash' do
          questionnaire.score_calculations.delete(:completion)
          outcome = OutcomeCalculation.new(answer).calculate
          expect(outcome.completion).to eq({})
        end
      end
    end

    describe '#update_scores' do
      it 'calculates scores' do
        expect(answer).to receive(:scores=)
        expect(answer).to receive(:actions=)
        expect(answer).to receive(:completion=)
        OutcomeCalculation.new(answer).update_scores
      end

      it 'assigns the calculated score to self.scores' do
        OutcomeCalculation.new(answer).update_scores
        expect(answer.scores).to eq("tot" => { "value" => 3, "label" => "Totaal",
                                               "score" => true, 'referenced_values' => [] })
      end

      it 'assigns the calculated actions to self.actions' do
        OutcomeCalculation.new(answer).update_scores
        expect(answer.actions).to eq('attention' => 5)
      end

      it 'assigns the calculated completion to self.completion' do
        OutcomeCalculation.new(answer).update_scores
        expect(answer.completion).to eq('value' => 0.9)
      end
    end

    describe '#value_by_regular_values' do
      it 'orders the regular values according to the questionnaire\'s question order' do
        allow(answer).to receive(:value_by_regular_values).and_return({ 'v_2' => 2, 'v_1' => 1 })
        allow(answer).to receive(:completed_at).and_return('completed_at')
        expect(OutcomeCalculation.new(answer).send(:value_by_regular_values).to_a).to eq({'v_1' => 1, 'v_2' => 2}.to_a)
      end

      # given that the only known question order is ['v_1', 'v_2', 'v_3']
      it 'sorts unknown question keys to the end of the regular values hash' do
        allow(answer).to receive(:value_by_regular_values).and_return(
          { 'v_2' => 2, 'v_5' => 5, 'v_4' => 4, 'v_3' => 3, 'v_1' => 1 }
        )
        allow(answer).to receive(:completed_at).and_return('completed_at')
        expect(OutcomeCalculation.new(answer).send(:value_by_regular_values).to_a).to eq({'v_1' => 1, 'v_2' => 2,
                                                                                          'v_3' => 3, 'v_5' => 5,
                                                                                          'v_4' => 4
                                                                                         }.to_a)
      end
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

module Quby::Answers::Entities
  describe Answer do
    let(:questionnaire) do
      inject_questionnaire 'foo', <<-END
        flag key: :test,  description_true: 'Test flag', description_false: 'Test flag uit',
                          shows_questions: [:v_1]
        flag key: :test2, description_true: 'Test flag 2', description_false: 'Test flag 2 uit',
                          hides_questions: [:v_2]

        panel do
          question :q1, type: :string, required: true
        end
      END
    end

    before do
      allow(Quby.questionnaires).to receive(:find).and_return(questionnaire)
    end

    describe 'initialization of hashes ' do
      it 'initializes value as an empty hash when given nothing' do
        expect(Answer.new.value).to eq({})
      end

      it 'initializes value as an empty hash when given explicit nils' do
        expect(Answer.new(value: nil).value).to eq({})
      end

      it 'initializes value as given' do
        expect(Answer.new(value: {a: 1, b: 2}).value).to eq({a: 1, b: 2})
      end
    end

    describe '#value_by_values' do
      it 'returns an empty hash when value is nil' do
        expect(Answer.new.value_by_values).to eq({})
      end
    end

    describe '#value_by_regular_values' do
      describe 'for empty answer' do
        it 'returns an empty hash' do
          expect(Answer.new.value_by_regular_values).to eq({})
        end
      end

      describe 'for a filled in answer' do
        let(:questionnaire) do
          inject_questionnaire 'foo', <<-END
            panel do
              question :q1, type: :radio do
                option :a1, value: 0
                option :a2, value: 1
              end

              question :q2, type: :scale do
                option :a1, value: 2
                option :a2, value: 3
              end

              question :q3, type: :select do
                option :a1, value: 4
                option :a2, value: 5
              end

              question :q4, type: :float
              question :q5, type: :integer
              question :q6, type: :string
            end
          END
        end

        it 'converts value\'s to the option\'s value :radio, :scale & :select questions' do
          expect(Answer.new(questionnaire_key: 'foo', value: {q1: :a1, q2: :a2, q3: :a1}).value_by_regular_values)
            .to eq({q1: 0, q2: 3, q3: 4})
        end

        it 'converts values of float and integer questions to floats and integers' do
          expect(Answer.new(questionnaire_key: 'foo', value: {q4: "1.2", q5: "3.4"}).value_by_regular_values)
            .to eq({q4: 1.2, q5: 3})
        end

        it 'does not touch other question types values, such as of :open' do
          expect(Answer.new(questionnaire_key: 'foo', value: {q6: "antwoord"}).value_by_regular_values)
            .to eq({q6: "antwoord"})
        end

        it 'does not touch values of questions that are not in the questionnaire anymore' do
          expect(Answer.new(questionnaire_key: 'foo', value: {q22: "val", q5: "3.4"}).value_by_regular_values)
            .to eq({q5: 3, q22: "val"})
        end
      end
    end

    describe "#scores" do
      let(:answer) { Quby.answers.create!('foo') }

      it "should be initialized as an empty hash" do
        expect(answer.scores).to eq({})
      end

      it 'can be accessed with indifferent access' do
        answer = Quby.answers.create!('foo', scores: {tot: {label: 'Totaal', value: 4}})
        answer = Quby.answers.reload(answer)
        expect(answer.scores[:tot][:label]).to eq 'Totaal'
        expect(answer.scores["tot"]["value"]).to eq 4
      end
    end

    describe '#actions' do
      it 'is initialized with empty hash' do
        answer = Quby.answers.create!('foo')
        expect(answer.actions).to eq({})
      end

      it 'can be accessed with indifferent access' do
        answer = Quby.answers.create!('foo', actions: {alarm: [:v1, :v2]})
        answer = Quby.answers.find('foo', answer.id)
        expect(answer.actions[:alarm]).to eq [:v1, :v2]
        expect(answer.actions["alarm"]).to eq [:v1, :v2]
      end
    end

    describe '#patient_id' do
      let(:answer) { Quby.answers.create!('foo') }

      it 'returns the patient[:id]' do
        answer[:patient][:id] = "123"
        expect(answer.patient_id).to eq "123"
      end

      it 'returns the patient_id if set in attributes' do
        answer[:patient_id] = "123"
        expect(answer.patient_id).to eq "123"
      end
    end

    describe "#mark_completed" do
      let(:answer) { Quby.answers.create!('foo') }
      let(:time)   { Time.gm(2011, 11, 5, 11, 24, 00) }

      it "should record the time when answer is completed" do
        Timecop.freeze(time) do
          answer.q1 = "Foo"
          answer.mark_completed(Time.now)
        end
        expect(answer.completed_at).to eq time
      end

      it "should record the time when answer is aborted" do
        Timecop.freeze(time) do
          answer.aborted = true
          answer.mark_completed(Time.now)
        end
        expect(answer.completed_at).to eq time
      end

      it "should not set completed_at for incomplete answers, even if it is called" do
        answer.mark_completed(Time.now)
        expect(answer.completed_at).to_not be
      end

      it "should not change when answer was previously completed" do
        Timecop.freeze(time) do
          answer.q1 = "Foo"
          answer.mark_completed(Time.now)
        end
        answer.q1 = "Bar"
        answer.mark_completed(Time.now)
        expect(answer.completed_at).to eq time
      end
    end
  end
end

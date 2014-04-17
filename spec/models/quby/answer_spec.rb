require 'spec_helper'

module Quby
  describe Answer do
    let(:questionnaire) do
      double(key: "foo",
             name: "Foo",
             questions: [double(key: "q1",
                                type: :open,
                                text_var: "a",
                                question_group: nil,
                                :hidden? => false,
                                parent: nil,
                                depends_on: [],
                                validations: [{type: :requires_answer}],
                                extra_data: {})],
             scores: [],
             score_calculations: {},
             actions: [],
             completion: nil,
             default_answer_value: {},
             last_update: Time.now)
    end

    before do
      Quby.questionnaire_finder.stub(find: questionnaire)
    end

    describe '#value_by_values' do
      it 'returns an empty hash when value is nil' do
        Answer.new.value_by_values.should eq({})
      end
    end

    describe '#value_by_regular_values' do
      describe 'for empty answer' do
        it 'returns an empty hash' do
          Answer.new.value_by_regular_values.should eq({})
        end
      end

      describe 'for a filled in answer' do
        let(:questionnaire) do
          double(key: "foo",
                 name: "Foo",
                 questions: [double(key: "q1",
                                    type: :radio,
                                    options: [
                                        double(key: 'a1', value: 0),
                                        double(key: 'a2', value: 1)
                                    ]
                             ),
                             double(key: "q2",
                                    type: :scale,
                                    options: [
                                        double(key: 'a1', value: 2),
                                        double(key: 'a2', value: 3)
                                    ]
                             ),
                             double(key: "q3",
                                    type: :select,
                                    options: [
                                        double(key: 'a1', value: 4),
                                        double(key: 'a2', value: 5)
                                    ]
                             ),
                             double(key: "q4",
                                    type: :float
                             ),
                             double(key: "q5",
                                    type: :integer
                             ),
                             double(key: "q6",
                                    type: :open)
                 ],
                 scores: [],
                 score_calculations: {},
                 actions: [],
                 completion: nil,
                 default_answer_value: {},
                 last_update: Time.now)
        end

        it 'converts value\'s to the option\'s value :radio, :scale & :select questions' do
          expect(Answer.new(value: {q1: :a1, q2: :a2, q3: :a1}).value_by_regular_values).to eq({q1: 0, q2: 3, q3: 4})
        end

        it 'converts values of float and integer questions to floats and integers' do
          expect(Answer.new(value: {q4: "1.2", q5: "3.4"}).value_by_regular_values).to eq({q4: 1.2, q5: 3})
        end

        it 'does not touch other question types values, such as of :open' do
          expect(Answer.new(value: {q6: "antwoord"}).value_by_regular_values).to eq({q6: "antwoord"})
        end

        it 'does not touch values of questions that are not in the questionnaire anymore' do
          expect(Answer.new(value: {q22: "val", q5: "3.4"}).value_by_regular_values).to eq({q5: 3, q22: "val"})
        end
      end
    end

    describe "#scores" do
      let(:answer) { Quby.answer_repo.create!('foo') }

      it "should be initialized as an empty hash" do
        answer.scores.should eq({})
      end

      it 'can be accessed with indifferent access' do
        answer = Quby.answer_repo.create!('foo', scores: {tot: {label: 'Totaal', value: 4}})
        answer = Quby.answer_repo.reload(answer)
        answer.scores[:tot][:label].should eq 'Totaal'
        answer.scores["tot"]["value"].should eq 4
      end
    end

    describe '#actions' do
      it 'is initialized with empty hash' do
        answer = Quby.answer_repo.create!('foo')
        answer.actions.should == {}
      end

      it 'can be accessed with indifferent access' do
        answer = Quby.answer_repo.create!('foo', actions: {alarm: [:v1, :v2]})
        answer = Quby.answer_repo.find('foo', answer.id)
        answer.actions[:alarm].should eq [:v1, :v2]
        answer.actions["alarm"].should eq [:v1, :v2]
      end
    end

    describe '#patient_id' do
      let(:answer) { Quby.answer_repo.create!('foo') }

      it 'returns the patient[:id]' do
        answer[:patient][:id] = "123"
        answer.patient_id.should == "123"
      end

      it 'returns the patient_id if set in attributes' do
        answer[:patient_id] = "123"
        answer.patient_id.should == "123"
      end
    end

    describe "#set_completed_at" do
      let(:answer) { Quby.answer_repo.create!('foo') }
      let(:time)   { Time.gm(2011, 11, 5, 11, 24, 00) }

      it "should record the time when answer is completed" do
        Timecop.freeze(time) do
          answer.q1 = "Foo"
          answer.set_completed_at
        end
        answer.completed_at.should == time
      end

      it "should record the time when answer is aborted" do
        Timecop.freeze(time) do
          answer.aborted = true
          answer.set_completed_at
        end
        answer.completed_at.should == time
      end

      it "should not set completed_at for incomplete answers, even if it is called" do
        answer.set_completed_at
        answer.completed_at.should_not be
      end

      it "should not change when answer was previously completed" do
        Timecop.freeze(time) do
          answer.q1 = "Foo"
          answer.set_completed_at
        end
        answer.q1 = "Bar"
        answer.set_completed_at
        answer.completed_at.should == time
      end
    end
  end
end

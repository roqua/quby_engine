# frozen_string_literal: true

require 'spec_helper'

module Quby::Answers::Services
  describe AnswerValidator do
    let(:default_questionnaire) do
      inject_questionnaire "test", <<-END
        panel do
          question :v_check_box, type: :check_box do
            title "Pick one"
            option :v_ck_a1, value: 1, description: 'Unicorns'
            option :v_ck_a2, value: 2, description: 'Rainbows'
          end
          question :v_radio, type: :radio do
            title "Pick one"
            option :a1, value: 1, description: 'Unicorns'
            option :a2, value: 2, description: 'Rainbows'
          end
          question :v_string, type: :string
          question :v_string2, type: :string, required: true
        end
        end_panel
      END
    end

    let(:default_answer_value) do
      { v_check_box: { v_ck_a1: 1, v_ck_a2: 0 },
        v_ck_a1: 1,
        v_ck_a2: 0,
        v_radio: "a1",
        v_string: "answer",
        v_string2: nil
      }
    end

    def build_answer(questionnaire: default_questionnaire, value: default_answer_value)
      answer = Quby.answers.create!(questionnaire.key, value: value, flags: {}, textvars: {})
      answer.extend AnswerValidations
      answer
    end


    def validator(questionnaire: default_questionnaire, answer: build_answer)
      described_class.new(questionnaire, answer)
    end

    describe '#depends_on_key_answered' do
      it 'returns true if a check box option is answered' do
        expect(validator.depends_on_key_answered(:v_ck_a1)).to be_truthy
      end
      it 'returns false if a check box option is not answered' do
        expect(validator.depends_on_key_answered(:v_ck_a2)).to be_falsey
      end
      it 'returns true if a radio option is answered' do
        expect(validator.depends_on_key_answered(:v_radio_a1)).to be_truthy
      end
      it 'returns false if a radio option is not answered' do
        expect(validator.depends_on_key_answered(:v_radio_a2)).to be_falsey
      end
      it 'returns true if a string question is answered' do
        expect(validator.depends_on_key_answered(:v_string)).to be_truthy
      end
      it 'returns false if a string question is not answered' do
        expect(validator.depends_on_key_answered(:v_string2)).to be_falsey
      end
    end

    describe '#validate' do
      it 'sets validation errors on the answer' do
        answer = build_answer
        validator(answer: answer).validate
        expect(answer.errors).to_not be_empty
      end

      context 'when answer is aborted' do
        it 'skips the validate_required validation' do
          answer = build_answer
          allow(answer).to receive(:aborted).and_return(true)
          validator(answer: answer).validate
          expect(answer.errors).to be_empty
        end

        it 'skips the validate_minimum_checked_required validation' do
          questionnaire = inject_questionnaire "test", <<-END
            question :v_ck, type: :check_box, required: true, minimum_checked_required: 2 do
              option :v_ck_a1, value: 1
              option :v_ck_a2, value: 2
              option :v_ck_a3, value: 3
            end
          END

          answer = build_answer(questionnaire: questionnaire, value: {v_ck: {v_ck_a1: 0, v_ck_a2: 0, v_ck_a3: 1}})
          validator(questionnaire: questionnaire, answer: answer).validate
          expect(answer.errors[:v_ck]).to include(message: "Not enough options checked.", valtype: :minimum_checked_required)

          answer = build_answer(questionnaire: questionnaire, value: {v_ck: {v_ck_a1: 0, v_ck_a2: 0, v_ck_a3: 1}})
          allow(answer).to receive(:aborted).and_return(true)
          validator(questionnaire: questionnaire, answer: answer).validate
          expect(answer.errors).to be_empty
        end

        it 'skips the validate_answer_group_minimum validation' do
          questionnaire = inject_questionnaire "test", <<-END
            question :v_1, type: :string, question_group: :grp, group_minimum_answered: 2
            question :v_2, type: :string, question_group: :grp, group_minimum_answered: 2
            question :v_3, type: :string, question_group: :grp, group_minimum_answered: 2
          END

          answer = build_answer(questionnaire: questionnaire, value: {v_1: nil, v_2: nil, v_3: 'bla'})
          validator(questionnaire: questionnaire, answer: answer).validate
          expect(answer.errors[:v_1]).to include(message: "Needs at least 2 question(s) answered.", valtype: :answer_group_minimum)
          expect(answer.errors[:v_2]).to include(message: "Needs at least 2 question(s) answered.", valtype: :answer_group_minimum)
          expect(answer.errors[:v_3]).to include(message: "Needs at least 2 question(s) answered.", valtype: :answer_group_minimum)

          answer = build_answer(questionnaire: questionnaire, value: {v_1: nil, v_2: nil, v_3: 'bla'})
          allow(answer).to receive(:aborted).and_return(true)
          validator(questionnaire: questionnaire, answer: answer).validate
          expect(answer.errors).to be_empty
        end
      end
    end
  end
end

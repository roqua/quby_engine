# frozen_string_literal: true

require 'spec_helper'

module Quby::Answers::Services
  describe AnswerValidator do
    let(:questionnaire) do
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

    let(:answer_value) do
      { v_check_box: { v_ck_a1: 1, v_ck_a2: 0 },
        v_ck_a1: 1,
        v_ck_a2: 0,
        v_radio: "a1",
        v_string: "answer",
        v_string2: nil
      }
    end

    let!(:answer) do
      answer = Quby.answers.create!(questionnaire.key, value: answer_value, flags: {}, textvars: {})
      answer.extend AnswerValidations
    end

    let(:validator) { described_class.new(questionnaire, answer) }

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
        validator.validate
        expect(answer.errors).to_not be_empty
      end

      context 'when answer is aborted' do
        before do
          allow(answer).to receive(:aborted).and_return(true)
        end

        it 'skips the validate_required validation' do
          validator.validate
          expect(answer.errors).to be_empty
        end
      end
    end
  end
end

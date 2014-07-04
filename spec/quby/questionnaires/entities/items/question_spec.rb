require 'spec_helper'

module Quby::Questionnaires::Entities
  describe Items::Question do
    let(:questionnaire) do
      Quby::Questionnaires::DSL.build("test") do
        question :radio, type: :radio, depends_on: [:check] do
          title "Testvraag"
          option :rad1
          option :rad2
        end

        question :check, type: :check_box do
          title "Checkbox vraag"
          option :check1
          inner_title 'foobar'
          option :check2 do
            question :subquestion, type: :string
          end
        end

        question :scale, type: :scale do
          option :scale1
          option :scale2
        end

        question :select, type: :scale do
          option :select1
          option :select2
        end

        question :int, type: :integer

        question :date, type: :date
      end
    end

    describe '#input_keys' do
      it 'should list all input keys' do
        expect(questionnaire.question_hash[:radio].input_keys).to eql [:radio_rad1, :radio_rad2]
        expect(questionnaire.question_hash[:check].input_keys).to eql [:check1, :check2]
        expect(questionnaire.question_hash[:scale].input_keys).to eql [:scale_scale1, :scale_scale2]
        expect(questionnaire.question_hash[:select].input_keys).to eql [:select_select1, :select_select2]
        expect(questionnaire.question_hash[:int].input_keys).to eql [:int]
        expect(questionnaire.question_hash[:date].input_keys).to eql [:date_dd, :date_mm, :date_yyyy]
      end
    end

    describe '#answer_keys' do
      it 'should list all answer keys' do
        expect(questionnaire.question_hash[:radio].answer_keys).to eql [:radio]
        expect(questionnaire.question_hash[:check].answer_keys).to eql [:check1, :check2]
        expect(questionnaire.question_hash[:scale].answer_keys).to eql [:scale]
        expect(questionnaire.question_hash[:select].answer_keys).to eql [:select]
        expect(questionnaire.question_hash[:int]  .answer_keys).to eql [:int]
        expect(questionnaire.question_hash[:date] .answer_keys).to eql [:date_dd, :date_mm, :date_yyyy]
      end
    end

    describe '#subquestion?' do
      it 'returns true for subquestions' do
        expect(questionnaire.question_hash[:subquestion].subquestion?).to be_true
      end
      it 'returns false for non-subquestions' do
        expect(questionnaire.question_hash[:check].subquestion?).to be_false
      end
    end

    describe '#key_in_use?' do
      let(:question) do
        question = Questions::RadioQuestion.new(:v_1, type: :radio)
        option   = QuestionOption.new(:op1, question)
        question.options << option
        question
      end

      it 'returns true if the key is the questions key' do
        expect(question.key_in_use?(:v_1)).to eql true
      end
      it 'returns true if the key is a questions key' do
        expect(question.key_in_use?(:v_1_op1)).to eql true
      end
      it 'return false if the key is not in use' do
        expect(question.key_in_use?(:v_1_op2)).to eql false
      end
    end

    describe '#expand_depends_on_input_keys' do
      it 'should expand the given depends_on keys' do
        expect(questionnaire.question_hash[:radio].depends_on).to eq [:check1, :check2]
      end
    end
  end
end

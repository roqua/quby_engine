# frozen_string_literal: true

require 'spec_helper'

module Quby::Questionnaires::Entities
  describe QuestionOption do
    let(:questionnaire) do
      Quby::Questionnaires::DSL.build("test") do
        question :one, type: :radio do
          title "Testvraag"
          option :a1, hides_questions: [:two]
          option :a2, hides_questions: [:three]
          option :a3, hides_questions: [:four]
          option :a4, shows_questions: [:five]
        end

        question :two, type: :radio
        question :three, type: :radio
        question :four, type: :radio
        question :five, type: :radio

        question :checkb, type: :check_box do
          title "Checkbox vraag"
          option :sixone
          option :sixtwo
        end
      end
    end

    describe "#hides_questions" do
      it "returns an array with the keys of the questions that are hidden when this option is picked" do
        questionnaire.question_hash[:one].options.first.hides_questions.should == [:two]
      end
    end

    describe "#shows_questions" do
      it "returns an array with the keys of the questions that are shown when this option is picked" do
        questionnaire.question_hash[:one].options.last.shows_questions.should == [:five]
      end
    end

    describe "#input_key" do
      it 'returns the key for checkbox questions' do
        option = questionnaire.question_hash[:checkb].options.first
        expect(option.input_key).to eq :sixone
      end

      it 'returns <question_key>_<option_key> for radio questions' do
        option = questionnaire.question_hash[:one].options.first
        expect(option.input_key).to eq :one_a1
      end
    end

    describe '#key_in_use?' do
      let(:option) do
        q = Question.new(:v_1, type: :radio)
        o = QuestionOption.new(:op1, q)
        q2 = Question.new(:v_1_op1_v1)
        o.questions << q2
        o
      end
      it 'bla' do
        expect(option.input_key).to eq :v_1_op1
      end

      it 'returns true if the key is the option key' do
        expect(option.key_in_use?(:v_1_op1)).to eql true
      end
      it 'returns true if the key is a sub questions key' do
        expect(option.key_in_use?(:v_1_op1_v1)).to eql true
      end
      it 'return false if the key is not in use' do
        expect(option.key_in_use?(:v_1_op1_v2)).to eql false
      end
    end
  end
end

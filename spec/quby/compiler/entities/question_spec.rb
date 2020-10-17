# frozen_string_literal: true

require 'spec_helper'

module Quby::Compiler::Entities
  describe Question do
    let(:questionnaire) do
      Quby::Compiler::DSL.build("test") do
        question :radio, type: :radio, depends_on: [:check] do
          title "Testvraag"
          context_free_title "Contextvrije testvraag"
          option :rad1
          option :rad2
        end

        question :check, type: :check_box, context_free_title: "Contextvrije testvraag" do
          title "Checkbox vraag"
          option :check1
          inner_title 'foobar'
          option :check2 do
            question :subquestion, type: :string
          end
        end

        question :scale, type: :scale do
          title 'Scale vraag'
          option :scale1
          option :scale2
        end

        question :select, type: :scale do
          option :select1
          option :select2
        end

        question :int, type: :integer

        question :date, type: :date, sbg_key: 'foo'
      end
    end

    let(:valid_question_options) { {type: :string} }
    subject(:question) { Question.new(:v_1, valid_question_options) }

    it 'validates the key to be a symbol' do
      questionnaire = Quby::Compiler::DSL.build("test2") do
          question "key", type: :radio
      end
      expect(questionnaire.questions.first.valid?).to eq false
      expect(questionnaire.questions.first.errors.full_messages).to eq ["Key Is not of type Symbol"]
    end

    describe 'sbg_key' do
      it 'can be set by options hash' do
        expect(questionnaire.question_hash[:date].sbg_key).to eq 'foo'
      end

      it 'returns nil when not set' do
        expect(questionnaire.question_hash[:int].sbg_key).to be_nil
      end
    end

    describe '#context_free_title' do
      it 'can be set by method call' do
        expect(questionnaire.question_hash[:radio].context_free_title).to eq 'Contextvrije testvraag'
      end

      it 'can be set by options hash' do
        expect(questionnaire.question_hash[:check].context_free_title).to eq 'Contextvrije testvraag'
      end

      it 'should fallback to title' do
        expect(questionnaire.question_hash[:scale].context_free_title).to eq 'Scale vraag'
      end
    end

    describe '#input_keys' do
      it 'should list all input keys' do
        expect(questionnaire.question_hash[:radio].input_keys).to eql [:radio_rad1, :radio_rad2]
        expect(questionnaire.question_hash[:check].input_keys).to eql [:check1, :check2]
        expect(questionnaire.question_hash[:scale].input_keys).to eql [:scale_scale1, :scale_scale2]
        expect(questionnaire.question_hash[:select].input_keys).to eql [:select_select1, :select_select2]
        expect(questionnaire.question_hash[:int].input_keys).to eql [:int]
        expect(questionnaire.question_hash[:date].input_keys.sort).to eql [:date_dd, :date_mm, :date_yyyy].sort
      end
    end

    describe '#claimed_keys' do
      it 'should list all answer keys' do
        expect(questionnaire.question_hash[:radio].claimed_keys).to eql [:radio]
        expect(questionnaire.question_hash[:check].claimed_keys).to eql [:check]
        expect(questionnaire.question_hash[:scale].claimed_keys).to eql [:scale]
        expect(questionnaire.question_hash[:select].claimed_keys).to eql [:select]
        expect(questionnaire.question_hash[:int]  .claimed_keys).to eql [:int]
        expect(questionnaire.question_hash[:date] .claimed_keys.sort).to eql(
          [:date, :date_dd, :date_mm, :date_yyyy].sort)
      end
    end

    describe '#answer_keys' do
      it 'should list all answer keys' do
        expect(questionnaire.question_hash[:radio].answer_keys).to eql [:radio]
        expect(questionnaire.question_hash[:check].answer_keys).to eql [:check1, :check2]
        expect(questionnaire.question_hash[:scale].answer_keys).to eql [:scale]
        expect(questionnaire.question_hash[:select].answer_keys).to eql [:select]
        expect(questionnaire.question_hash[:int]  .answer_keys).to eql [:int]
        expect(questionnaire.question_hash[:date] .answer_keys.sort).to eql [:date_dd, :date_mm, :date_yyyy].sort
      end
    end

    describe '#subquestion?' do
      it 'returns true for subquestions' do
        expect(questionnaire.question_hash[:subquestion].subquestion?).to be_truthy
      end
      it 'returns false for non-subquestions' do
        expect(questionnaire.question_hash[:check].subquestion?).to be_falsey
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

    describe '#default_position' do
      it 'defaults to halfway between minimum and maximum' do
        question = Questions::IntegerQuestion.new(:v_1, type: :integer, as: :slider)
        question.validations << {type: :minimum, value: 1, subtype: :number}
        question.validations << {type: :maximum, value: 5, subtype: :number}
        expect(question.default_position).to eq 3
      end

      it 'overrides the default if set' do
        question = Questions::IntegerQuestion.new(:v_1, type: :integer, as: :slider, default_position: 4)
        question.validations << {type: :minimum, value: 1, subtype: :number}
        question.validations << {type: :maximum, value: 5, subtype: :number}
        expect(question.default_position).to eq 4
      end

      it 'allows explicit nil value' do
        question = Questions::IntegerQuestion.new(:v_1, type: :integer, as: :slider, default_position: :hidden)
        question.validations << {type: :minimum, value: 1, subtype: :number}
        question.validations << {type: :maximum, value: 5, subtype: :number}
        expect(question.default_position).to eq :hidden
      end
    end

    describe '#show_values' do
      it 'defaults to :bulk' do
        expect(question.show_values).to eq :bulk
      end

      [:paged, :all, :none].each do |val|
        it "can be set to #{val}" do
          valid_question_options[:show_values] = val
          expect(question.show_values).to eq val
        end
      end

      it "can't be set other values" do
        valid_question_options[:show_values] = :error
        expect(question).to be_invalid
        expect(question.errors[:show_values][0])
          .to eq "option invalid: error. Valid options: :all, :none, :paged, :bulk)"
      end
    end

    describe '#deselectable' do
      it 'is true by default' do
        expect(question.deselectable).to eq(true)
      end

      describe 'when deselectable is set to be false through options' do
        let(:valid_question_options) { {type: :string, deselectable: false} }
        it 'is false' do
          expect(question.deselectable).to eq(false)
        end
      end

      describe 'when deselectable is set to be true through options' do
        let(:valid_question_options) { {type: :string, deselectable: true} }
        it 'is true' do
          expect(question.deselectable).to eq(true)
        end
      end
    end
  end
end

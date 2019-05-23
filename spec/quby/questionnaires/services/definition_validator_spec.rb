# frozen_string_literal: true

require 'spec_helper'

module Quby::Questionnaires::Services
  describe DefinitionValidator do
    let(:questionnaire) { Quby::Questionnaires::DSL.build('test', 'title "Test"') }

    def make_definition(definition = 'title "Test"')
      Quby::Questionnaires::Entities::Definition.new(key: 'test', sourcecode: definition)
    end

    describe "fields#answer_keys and fields#input_keys need to be symbols" do
      before do
        allow(Quby::Questionnaires::DSL).to receive(:build_from_definition).and_return(questionnaire)
      end

      it 'passes when answer_keys and input_keys are symbols' do
        valid_definition = make_definition
        questionnaire.fields.answer_keys << :v_foo
        questionnaire.fields.input_keys << :v_foo_a1
        valid_definition.valid?
        expect(valid_definition.errors).to be_empty
      end

      it 'fails when an answer_keys is not a symbol' do
        invalid_definition = make_definition
        questionnaire.fields.answer_keys << 'v_foo'
        invalid_definition.valid?
        expect(invalid_definition.errors[:sourcecode].first[:message])
          .to include("Answer key v_foo is not a symbol")
      end

      it 'fails when an input_keys is not a symbol' do
        invalid_definition = make_definition
        questionnaire.fields.input_keys << 'v_foo_a1'
        invalid_definition.valid?
        expect(invalid_definition.errors[:sourcecode].first[:message])
          .to include("Input key v_foo_a1 is not a symbol")
      end
    end

    describe "questionnaire needs a title" do
      it "throws an error if the questionnaire does not have a title" do
        invalid_definition = make_definition("")
        invalid_definition.valid?
        expect(invalid_definition.errors[:sourcecode].first[:message])
          .to include("Questionnaire title is missing.")
      end

      it "throws an error if the title is empty" do
        invalid_definition = make_definition(<<-END)
          title ""
        END
        invalid_definition.valid?
        expect(invalid_definition.errors[:sourcecode].first[:message])
          .to include("Questionnaire title is missing.")
      end
    end

    describe 'questions with activemodel validation errors' do
      it "throws an error if the question to be hidden does not exist" do
        invalid_definition = make_definition(<<-END)
          title "Test"
          question :v_1, type: :string, show_values: :error do
            title "Testvraag"
          end
        END
        invalid_definition.valid?
        expect(invalid_definition.errors[:sourcecode].first[:message])
          .to include("Question v_1 is invalid: Show values option invalid: error.")
      end
    end

    describe ":hides_questions" do
      it "throws an error if the question to be hidden does not exist" do
        invalid_definition = make_definition(<<-END)
          title "Test"
          question :v_1, type: :radio do
            title "Testvraag"
            option :a1, hides_questions: [:v_2]
          end
        END
        invalid_definition.valid?
        expect(invalid_definition.errors[:sourcecode].first[:message])
          .to include("Question v_1 option a1 hides_questions references nonexistent question v_2")
      end

      it "throws an error if the question to be hidden is a subquestion" do
        invalid_definition = make_definition(<<-END)
          title "Test"
          question :v_1, type: :radio do
            title "Testvraag"
            option :a1, hides_questions: [:v_1_a1_sq] do
              question :v_1_a1_sq, type: :string
            end
          end
        END
        invalid_definition.valid?
        expect(invalid_definition.errors[:sourcecode].first[:message])
          .to include("Question v_1 option a1 hides_questions references subquestion v_1_a1_sq")
      end

      it 'does not throw an error when the question to be hidden exists' do
        definition = make_definition(<<-END)
          title "Test"
          question :v_1, type: :radio do
            title "Testvraag"
            option :a1, hides_questions: [:v_2]
          end

          question :v_2, type: :textarea do
            title "Testvraag"
          end
        END
        expect(definition.valid?).to be_truthy
      end
    end

    describe ":shows_questions" do
      it "throws an error if the question to be shown does not exist" do
        invalid_definition = make_definition(<<-END)
          title "Test"
          question :v_1, type: :radio do
            title "Testvraag"
            option :a1, shows_questions: [:v_2]
          end
        END
        invalid_definition.valid?
        expect(invalid_definition.errors[:sourcecode].first[:message])
          .to include("Question v_1 option a1 shows_questions references nonexistent question v_2")
      end

      it "throws an error if the question to be shown is a subquestion" do
        invalid_definition = make_definition(<<-END)
          title "Test"
          question :v_1, type: :radio do
            title "Testvraag"
            option :a1, shows_questions: [:v_1_a1_sq] do
              question :v_1_a1_sq, type: :string
            end
          end
        END
        invalid_definition.valid?
        expect(invalid_definition.errors[:sourcecode].first[:message])
          .to include("Question v_1 option a1 shows_questions references subquestion v_1_a1_sq")
      end

      it 'does not throw an error when the question to be shown exists' do
        definition = make_definition(<<-END)
          title "Test"
          question :v_1, type: :radio do
            title "Testvraag"
            option :a1, shows_questions: [:v_2]
          end

          question :v_2, type: :textarea do
            title 'Testvraag'
          end
        END
        expect(definition.valid?).to be_truthy
      end
    end

    describe ":default_invisible" do
      it 'throws an error if a subquestion has default_invisible set' do
        invalid_definition = make_definition(<<-END)
          title "Test"
          question :v_1, type: :radio do
            title "Testvraag"
            option :a1
            option :a2, shows_questions: [:v_1_a1_sq] do
              question :v_1_a1_sq, type: :string, default_invisible: true
            end
          end
        END
        invalid_definition.valid?
        expect(invalid_definition.errors[:sourcecode].first[:message])
          .to include("Question v_1_a1_sq is a subquestion with default_invisible")
      end

      it 'does not throw an error if a non-subquestion has default_invisible set' do
        valid_definition = make_definition(<<-END)
          title "Test"
          question :v_1, type: :string default_invisible: true
        END
        valid_definition.valid?
        expect(valid_definition.errors[:sourcecode].first[:message]).to be_truthy
      end
    end

    describe ":validates_question_key_format" do
      it "validates length of the question keys" do
        long_key = make_definition(<<-END)
          title "Test"
          question :questionthree, type: :radio do
            title "Testvraag"
            option :a1, description: 'some_description'
          end
        END
        valid_key = make_definition(<<-END)
          title "Test"
          question :v_12345678901, type: :radio do
            title "Testvraag"
            option :a1, description: 'some_description'
          end
        END
        expect(long_key.valid?).to be_falsey
        expect(valid_key.valid?).to be_truthy
      end

      it "validates that question key starts with a `v_`" do
        invalid_key = make_definition(<<-END)
          title "Test"
          question :one, type: :radio do
            title "Testvraag"
            option :a1, description: 'some_description', hides_questions: [:two]
          end
        END
        valid_key = make_definition(<<-END)
          title "Test"
          question :v_2, type: :radio do
            title "Testvraag"
            option :a1, description: 'some_description'
          end
        END
        expect(invalid_key.valid?).to be_falsey
        expect(valid_key.valid?).to be_truthy
      end

      it "validates check_box question options start with `v_`" do
        invalid_keys = make_definition(<<-END)
          title "Test"
          question :v_4, type: :check_box do
            title "Testvraag met een check_box"
            option :q1, description: 'some_description'
          end
        END
        valid_keys = make_definition(<<-END)
          title "Test"
          question :v_4, type: :check_box do
            title "Testvraag met een check_box"
            option :v_q1, description: 'some_description'
            inner_title 'blaat'
            option :v_q2, description: 'more_description'
          end
        END
        expect(invalid_keys.valid?).to be_falsey
        expect(valid_keys.valid?).to be_truthy
      end

      it "validates check_box question options length" do
        invalid_keys = make_definition(<<-END)
          title "Test"
          question :v_4, type: :check_box do
            title "Testvraag met een check_box"
            option :v_q1_has_a_very_long_key, description: 'some_description'
          end
        END
        valid_keys = make_definition(<<-END)
          title "Test"
          question :v_4, type: :check_box do
            title "Testvraag met een check_box"
            option :v_q1, description: 'some_description'
          end
        END
        expect(invalid_keys.valid?).to be_falsey
        expect(valid_keys.valid?).to be_truthy
      end

      it "validates question date keys" do
        invalid_keys = make_definition(<<-END)
          title "Test"
          question :v_6, type: :date, year_key: :invalid_key, month_key: :v_62, day_key: :v_63 do
            title "Testvraag met een datum"
          end
        END
        valid_keys = make_definition(<<-END)
          title "Test"
          question :v_6, type: :date, year_key: :v_61, month_key: :v_62, day_key: :v_63 do
            title "Testvraag met een datum"
          end
        END
        expect(invalid_keys.valid?).to be_falsey
        expect(valid_keys.valid?).to be_truthy
      end
    end

    describe 'subquestion validation' do
      it 'does not accept subquestions in question of type select' do
        select_type_without_subquestions = make_definition(<<-END)
          title "Test"
          question :v_7, type: :select do
            title "Vraag met hidden options"
            option :a1, :value => 1, :description => "Keuze1"
            option :a2, :value => 2, :description => "Keuze2"
          end
        END
        select_type_with_subquestions = make_definition(<<-END)
          title "Test"
          question :v_8, type: :select do
            title "Vraag met hidden options"
            option :a3, :value => 1, :description => "Keuze1"
            option :a4, :value => 2, :description => "Keuze2"
            option :a5, :value => 7, :description => "Anders, namelijk:"
            question :v_8a, :type => :radio do
              option :a7a, :value => 11, :description => "Keuze 3"
              option :a7b, :value => 12, :description => "Keuze 4"
            end
          end
        END

        expect(select_type_with_subquestions.valid?).to be_falsey
        expect(select_type_without_subquestions.valid?).to be_truthy
      end
    end

    describe 'score key validation' do
      it 'accepts score keys that are the correct length' do
        valid_definition = make_definition(<<-END)
          title "Test"
          score 'ok_key_length', label: 'some_label',
            schema: [{key: :wait_what_this_key_is_very_long, label: 'Score', export_key: :wat}] do
            { wait_what_this_key_is_very_long: 42 }
          end
        END
        expect(valid_definition).to be_valid
      end

      it 'reject score keys that are too long' do
        invalid_definition = make_definition(<<-END)
          title "Test"
          score 'score_whose_key_is_longer_than_max', label: 'some_label',
            schema: [{key: :t_score, label: 'Score', export_key: :wat}] do
            { t_score: 42 }
          end
        END
        expect(invalid_definition).not_to be_valid
      end

      it 'reject score key if already defined' do
        definition = make_definition(<<-END)
          title "Test"
          question :v_6, type: :radio, title: 'foo'
          score 'foo_score', label: 'some_label',
            schema: [{key: :t_score, label: 'Score', export_key: :wat}] do
            { t_score: 42 }
          end
          score 'foo_score', label: 'some_label',
            schema: [{key: :t_score, label: 'Score', export_key: :wat}] do
            { t_score: 43 }
          end
        END
        expect(definition).not_to be_valid
      end
    end

    describe 'score label validation' do
      it 'accepts the label option' do
        score_definition = make_definition(<<-END)
          title "Test"
          score 'score_key', label: 'score_label',
            schema: [{key: :value, label: 'Score', export_key: :sc1}] do {value: 42} end
        END
        expect(score_definition).to be_valid
      end

      it 'rejects score definitions without the label option' do
        score_definition = make_definition(<<-END)
          title "Test"
          score 'score_key',
            schema: [{key: :value, label: 'Score', export_key: :sc1}] do {value: 42} end
        END
        expect(score_definition).not_to be_valid
      end
    end

    describe 'title validations' do
      context ':title and :context_free_title do not exist' do
        it 'fails' do
          definition = make_definition(<<-END)
            title "Test"
            question :v_6, type: :radio
          END
          expect(definition.valid?).to be false
        end

        it 'does not fail with :allow_blank_titles option' do
          definition = make_definition(<<-END)
            title "Test"
            question :v_6, type: :radio, allow_blank_titles: true do
            end
          END
          expect(definition.valid?).to be true
        end

        it 'does not fail on table question' do
          definition = make_definition(<<-END)
            title "Test"
            table columns: 4 do
            end
          END
          expect(definition.valid?).to be true
        end
      end

      context ':title or :context_free_title exist' do
        it 'does not fail when :title exists' do
          definition = make_definition(<<-END)
            title "Test"
            question :v_6, type: :radio do
              title 'foo'
            end
          END
          expect(definition.valid?).to be true
        end

        it 'does not fail when :context_free_title exists' do
          definition = make_definition(<<-END)
            title "Test"
            question :v_6, type: :radio do
              context_free_title 'bar'
            end
          END
          expect(definition.valid?).to be true
        end
      end

      context 'default question options' do
        it 'is valid when no title exist and default question options set to true' do
          definition = make_definition(<<-END)
            title "Test"
            default_question_options allow_blank_titles: true
            question :v_6, type: :radio do
              context_free_title 'bar'
            end
          END
          expect(definition).to be_valid
        end
      end

      context 'subquestions' do
        it 'acts the same on subquestions' do
          definition = make_definition(<<-END)
            title "Test"
            default_question_options allow_blank_titles: true
            question :v_22a, :type => :check_box do
              option :v_22_a01, :description => "Niet genoeg informatie"
            end
          END
          expect(definition).to be_valid
        end

        it 'acts the same on title_question' do
          definition = make_definition(<<-END)
            title "Test"
            default_question_options allow_blank_titles: true
            question :v_100a, :type => :radio, :presentation => :horizontal, :required => false do
              title "  100a."
              title_question :v_100a_01, :type => :string, :title => ''
              option :a1, :value => 0, :description => "Optie 1"
              option :a2, :value => 1, :description => "Optie 2"
              option :a3, :value => 2, :description => "Optie 3"
            end
          END
          expect(definition).to be_valid
        end
      end

      context 'spaces before question number' do
        it 'is valid when title starts with 0 or 1 spaces before question number' do
          definition = make_definition(<<-END)
            title "Test"
            question :v_1, type: :string do
              title "1\\\\. Title"
            end
          END
          expect(definition).to be_valid
        end

        it 'is invalid when title starts with more than 1 space before question number' do
          definition = make_definition(<<-END)
            title "Test"
            question :v_1, type: :string do
              title "  1\\\\. Title"
            end
          END
          expect(definition).to be_invalid
        end
      end
    end

    describe 'subquestions inside a table' do
      it 'accepts title_questions' do
        expect(make_definition(<<-END).valid?).to be_truthy
          title "Test"
          panel do
            table do
              question :v_1, type: :radio do
                title "Question"
                title_question :v_2, :type => :string, :title => "Title Question", :depends_on => [:v_1_a1]
                option :a1, value: 1, description: "Option 1"
                option :a2, value: 2, description: "Option 2"
              end
            end
          end
        END
      end

      it 'does not accept subquestions in questions inside a table' do
        expect(make_definition(<<-END).valid?).to be_falsey
          title "Test"
          panel do
            table do
              question :v_1, type: :radio do
                title "Question"
                option :a1, value: 1, description: "Option 1"
                option :a2, value: 2, description: "Option 2" do
                  question :v_2, type: :string, title: 'Subquestion'
                end
              end
            end
          end
        END
      end
    end

    describe 'flags' do
      it 'does not accept shows_questions arrays with unknown keys' do
        expect(make_definition(<<-END).valid?).to be_falsey
          title "Test"
          flag key: 'a', description: 'a flag', shows_questions: [:v_22]
        END
      end

      it 'does not accept hides_questions arrays with unknown keys' do
        expect(make_definition(<<-END).valid?).to be_falsey
          title "Test"
          flag key: 'a', description: 'a flag', hides_questions: [:v_22]
        END
      end

      it 'accepts shows_questions arrays with known keys' do
        expect(make_definition(<<-END).valid?).to be_truthy
          title "Test"
          flag key: 'a', description: 'a flag', shows_questions: [:v_22]
          question :v_22, type: :string do
            title 'Question'
          end
        END
      end

      it 'accepts hides_questions arrays with known keys' do
        expect(make_definition(<<-END).valid?).to be_truthy
          title "Test"
          flag key: 'a', description: 'a flag', hides_questions: [:v_22]
          question :v_22, type: :string do
            title 'Question'
          end
        END
      end
    end

    describe 'respondent_types' do
      it 'is optional' do
        expect(make_definition(<<-END).valid?).to be_truthy
          title "Test"
        END
      end

      it 'accepts valid respondent_types' do
        expect(make_definition(<<-END).valid?).to be_truthy
          title "Test"
          respondent_types :patient, :parent
        END
      end

      it 'does not accept invalid respondent_types' do
        expect(make_definition(<<-END).valid?).to be_falsey
          title "Test"
          respondent_types :santa_claus
        END
      end
    end

    describe 'outcome_tables' do
      it 'checks if outcome tables are valid' do
        expect(make_definition(<<-END).valid?).to be_truthy
          title "Test"
          score(:key, label: 'score', schema: [{key: :value, label: 'Score', export_key: :key}]) do {value: 'oh1'} end
          score(:key2, label: 'score2', schema: [{key: :value, label: 'Score 2', export_key: :key2}]) do {value: 'oh2'} end

          outcome_table key: :test_outcome_table,
                        score_keys: %i[key key2],
                        subscore_keys: [:value]
        END
      end

      it 'fails if there is an error in outcome tables' do
        definition = make_definition(<<-END)
          title "Test"
          score(:key, label: 'score', schema: [{key: :value, label: 'Score', export_key: :key}]) do {value: 'oh1'} end
          score(:key2, label: 'score2', schema: [{key: :value, label: 'Score 2', export_key: :key2}]) do {value: 'oh2'} end

          outcome_table key: :test_outcome_table,
                        score_keys: %i[key unknown_key_1 unknown_key_2],
                        subscore_keys: [:value]
        END
        expect(definition.valid?).to be_falsey
        expect(definition.errors.full_messages.first).to include('Score keys :unknown_key_1 not found in score schemas')
      end
    end
  end
end

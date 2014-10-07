require 'spec_helper'

module Quby::Questionnaires::Services
  describe DefinitionValidator do
    let(:questionnaire) { Quby::Questionnaires::Entities::Questionnaire.new('test') }

    def make_definition(definition)
      Quby::Questionnaires::Entities::Definition.new(key: 'test', sourcecode: definition)
    end

    describe ":hides_questions" do
      it "throws an error if the question to be hidden does not exist" do
        invalid_definition = make_definition(<<-END)
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
          question :v_1, type: :radio do
            title "Testvraag"
            option :a1, hides_questions: [:v_2]
          end

          question :v_2, type: :textarea
        END
        expect(definition.valid?).to be_true
      end
    end

    describe ":shows_questions" do
      it "throws an error if the question to be shown does not exist" do
        invalid_definition = make_definition(<<-END)
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
          question :v_1, type: :radio do
            title "Testvraag"
            option :a1, shows_questions: [:v_2]
          end

          question :v_2, type: :textarea
        END
        expect(definition.valid?).to be_true
      end
    end

    describe ":default_invisible" do
      it 'throws an error if a subquestion has default_invisible set' do
        invalid_definition = make_definition(<<-END)
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
          question :v_1, type: :string default_invisible: true
        END
        valid_definition.valid?
        expect(valid_definition.errors[:sourcecode].first[:message]).to be_true
      end
    end

    describe ":validates_question_key_format" do
      it "validates length of the question keys" do
        long_key = make_definition(<<-END)
          question :questionthree, type: :radio do
            title "Testvraag"
            option :a1, description: 'some_description'
          end
        END
        valid_key = make_definition(<<-END)
          question :v_12345678901, type: :radio do
            title "Testvraag"
            option :a1, description: 'some_description'
          end
        END
        long_key.valid?.should be_false
        valid_key.valid?.should be_true
      end

      it "validates that question key starts with a `v_`" do
        invalid_key = make_definition(<<-END)
          question :one, type: :radio do
            title "Testvraag"
            option :a1, description: 'some_description', hides_questions: [:two]
          end
        END
        valid_key = make_definition(<<-END)
          question :v_2, type: :radio do
            title "Testvraag"
            option :a1, description: 'some_description'
          end
        END
        invalid_key.valid?.should be_false
        valid_key.valid?.should be_true
      end

      it "validates check_box question options start with `v_`" do
        invalid_keys = make_definition(<<-END)
          question :v_4, type: :check_box do
            title "Testvraag met een check_box"
            option :q1, description: 'some_description'
          end
        END
        valid_keys = make_definition(<<-END)
          question :v_4, type: :check_box do
            title "Testvraag met een check_box"
            option :v_q1, description: 'some_description'
            inner_title 'blaat'
            option :v_q2, description: 'more_description'
          end
        END
        invalid_keys.valid?.should be_false
        valid_keys.valid?.should be_true
      end

      it "validates check_box question options length" do
        invalid_keys = make_definition(<<-END)
          question :v_4, type: :check_box do
            title "Testvraag met een check_box"
            option :v_q1_has_a_very_long_key, description: 'some_description'
          end
        END
        valid_keys = make_definition(<<-END)
          question :v_4, type: :check_box do
            title "Testvraag met een check_box"
            option :v_q1, description: 'some_description'
          end
        END
        invalid_keys.valid?.should be_false
        valid_keys.valid?.should be_true
      end

      it "validates question date keys" do
        invalid_keys = make_definition(<<-END)
          question :v_6, type: :date, year_key: :invalid_key, month_key: :v_62, day_key: :v_63 do
            title "Testvraag met een datum"
          end
        END
        valid_keys = make_definition(<<-END)
          question :v_6, type: :date, year_key: :v_61, month_key: :v_62, day_key: :v_63 do
            title "Testvraag met een datum"
          end
        END
        invalid_keys.valid?.should be_false
        valid_keys.valid?.should be_true
      end
    end

    describe 'the validation' do
      it 'does not accept subquestions in question of type select' do
        select_type_without_subquestions = make_definition(<<-END)
          question :v_7, type: :select do
            title "Vraag met hidden options"
            option :a1, :value => 1, :description => "Keuze1"
            option :a2, :value => 2, :description => "Keuze2"
          end
        END
        select_type_with_subquestions = make_definition(<<-END)
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
        select_type_with_subquestions.valid?.should be_false
        select_type_without_subquestions.valid?.should be_true
      end

      it 'accepts score keys that are the correct length' do
        valid_definition = make_definition(<<-END)
          score 'ok_key_length' do
            { wait_what_this_key_is_very_long: 42 }
          end
        END
        expect(valid_definition.valid?).to be true
      end

      it 'reject score keys that are too long' do
        invalid_definition = make_definition(<<-END)
          score 'score_whose_key_is_longer_than_max' do
            { t_score: 42 }
          end
        END
        expect(invalid_definition.valid?).to be false
      end

      it 'reject score key if already defined' do
        definition = make_definition(<<-END)
          question :v_6, type: :radio do
          end
          score 'foo_score' do
            { t_score: 42 }
          end
          score 'foo_score' do
            { t_score: 43 }
          end
        END
        expect(definition.valid?).to be false
      end
    end

    describe 'subquestions inside a table' do
      it 'accepts title_questions' do
        make_definition(<<-END).valid?.should be_true
          panel do
            table do
              question :v_1, type: :radio do
                title "Question"
                title_question :v_2, :type => :string, :title => "", :depends_on => [:v_1_a1]
                option :a1, value: 1, description: "Option 1"
                option :a2, value: 2, description: "Option 2"
              end
            end
          end
        END
      end

      it 'does not accept subquestions in questions inside a table' do
        make_definition(<<-END).valid?.should be_false
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
        make_definition(<<-END).valid?.should be_false
          flag key: 'a', description_true: '', description_false: '', shows_questions: [:v_22]
        END
      end

      it 'does not accept hides_questions arrays with unknown keys' do
        make_definition(<<-END).valid?.should be_false
          flag key: 'a', description_true: '', description_false: '', hides_questions: [:v_22]
        END
      end

      it 'accepts shows_questions arrays with known keys' do
        make_definition(<<-END).valid?.should be_true
          flag key: 'a', description_true: '', description_false: '', shows_questions: [:v_22]
          question :v_22, type: :string
        END
      end

      it 'accepts hides_questions arrays with known keys' do
        make_definition(<<-END).valid?.should be_true
          flag key: 'a', description_true: '', description_false: '', hides_questions: [:v_22]
          question :v_22, type: :string
        END
      end
    end
  end
end

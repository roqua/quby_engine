require 'spec_helper'

module Quby::Answers::Services
  describe AnswerValidations do
    let(:value) do
      {
        "v_placeholder" => "a0",
        "v_default_invisible" => "a0",
        "v_hides" => "a0",
        "v_shows" => "a0",
        "v_hides_2" => "a0",
        "v_hidden" => "a0",
        "v_hidden_and_shown" => "a0",
        "v_shown_and_hidden" => "a0",
        "v_default_invisible_shown" => "a0",
        "v_parent" => "a1",
        "v_child" => "a0",
        "v_parent2" => "a0",
        "v_check_box" => {"v_c1" => 0, "v_c2" => 1, "v_c3" => 1},
        "v_c1" => 0, "v_c2" => 1, "v_c3" => 1,
        "v_hidden_type" => "a0",
        "v_depend" => nil,
        "v_depends_on" => "a0",
        "v_depends_on2" => nil,
        "v_depend_title" => nil,
        "v_depended_check" => {v_depended_check_a1: 1, v_depended_check_a2: 0},
        "v_depended_check_a1" => 1,
        "v_depended_check_a2" => 0,
        "v_depend2_title" => nil,
        "v_depended_check2" => {v_depended_check2_a1: 0, v_depended_check2_a2: 1},
        "v_depended_check2_a1" => 0,
        "v_depended_check2_a2" => 1,
        "v_invalid_integer" => "0.2",
        "v_invalid_float" => "0,2",
        "v_invalid_regexp" => "b",
        "v_required" => nil,
        "v_valid_integer" => "2",
        "v_valid_float" => "0.2",
        "v_valid_regexp" => "a",
        "v_valid_required" => "a",
        "v_under_minimum" => "5",
        "v_over_minimum" => "10",
        "v_under_maximum" => "5",
        "v_over_maximum" => "11",
        "v_too_many_checked" => {"v_too_many_checked_a0" => 1,
                                 "v_too_many_checked_a1" => 1},
        "v_too_many_checked_a0" => 1,
        "v_too_many_checked_a1" => 1,
        "v_not_too_many_checked" => {"v_not_too_many_checked_a0" => 1,
                                     "v_not_too_many_checked_a1" => 0},
        "v_not_too_many_checked_a0" => 1,
        "v_not_too_many_checked_a1" => 0,
        "v_over_maximum_checked_allowed" => {"v_over_maximum_checked_allowed_a0" => 1,
                                             "v_over_maximum_checked_allowed_a1" => 0},
        "v_under_minimum_checked_required" => {"v_under_minimum_checked_allowed_a0" => 1,
                                               "v_under_minimum_checked_allowed_a1" => 0},
        "v_all_checked" => {"v_all_checked_a0" => 1,
                            "v_all_checked_a1" => 1},
        "v_all_checked_a0" => 1,
        "v_all_checked_a1" => 1,
        "v_not_all_checked" => {"v_not_all_checked_a0" => 1,
                                "v_not_all_checked_a1" => 0},
        "v_not_all_checked_a0" => 1,
        "v_not_all_checked_a1" => 0,
        "v_answer_group_under_minimum" => nil,
        "v_answer_group_under_minimum1" => nil,
        "v_answer_group_over_minimum" => "a",
        "v_answer_group_over_minimum1" => "a",
        "v_answer_group_under_maximum" => nil,
        "v_answer_group_under_maximum1" => nil,
        "v_answer_group_over_maximum" => "a",
        "v_answer_group_over_maximum1" => "a",

        "v_check_answer_group_under_minimum" => {"v_check_answer_group_under_minimum_a1" => 1,
                                                 "v_check_answer_group_under_minimum_a2" => 0},
        "v_check_answer_group_under_minimum_a1" => 1, "v_check_answer_group_under_minimum_ a2" => 0,

        "v_check_answer_group_under_minimum1" => {"v_check_answer_group_under_minimum1_a1" => 0,
                                                  "v_check_answer_group_under_minimum1_a2" => 1},
        "v_check_answer_group_under_minimum1_a1" => 0, "v_check_answer_group_under_minimum1_a2" => 1,

        "v_check_answer_group_over_minimum" => {"v_check_answer_group_over_minimum_a1" => 1,
                                                "v_check_answer_group_over_minimum_a2" => 0},
        "v_check_answer_group_over_minimum_a1" => 1, "v_check_answer_group_over_minimum_a2" => 0,

        "v_check_answer_group_over_minimum1" => {"v_check_answer_group_over_minimum1_a1" => 0,
                                                 "v_check_answer_group_over_minimum1_a2" => 1},
        "v_check_answer_group_over_minimum1_a1" => 0, "v_check_answer_group_over_minimum1_a2" => 1,

        "v_check_answer_group_under_maximum" => {"v_check_answer_group_under_maximum_a1" => 1,
                                                 "v_check_answer_group_under_maximum_a2" => 0},
        "v_check_answer_group_under_maximum_a1" => 1, "v_check_answer_group_under_maximum_a2" => 0,

        "v_check_answer_group_under_maximum1" => {"v_check_answer_group_under_maxim um1_a1" => 0,
                                                  "v_check_answer_group_under_maximum1_a2" => 1},
        "v_check_answer_group_under_maximum1_a1" => 0, "v_check_answer_group_under_maximum1_a2" => 1,

        "v_check_answer_group_over_maximum" => {"v_check_answer_group_over_maximum_a1" => 1,
                                                "v_check_answer_group_over_maximum_a2" => 0},
        "v_check_answer_group_over_maximum_a1" => 1, "v_check_answer_group_over_maximum_a2" => 0,

        "v_check_answer_group_over_maximum1" => {"v_check_answer_group_over_maximum1_a1" => 0,
                                                 "v_check_answer_group_over_maximum1_a2" => 1},
        "v_check_answer_group_over_maximum1_a1 " => 0, "v_check_answer_group_over_maximum1_a2" => 1
      }
    end

    let(:answer) do
      Quby::Answers::Entities::Answer.new(questionnaire_key: 'all_validations', value: value).tap(&:enhance_by_dsl)
    end

    before do
      answer.extend AnswerValidations
    end

    describe '#hidden_questions' do
      it 'sets the @hidden_questions attribute to the hidden questions' do
        expect(answer.hidden_questions).to include(:v_hidden)
      end
      it 'does not add the hidden questions keys to @hidden_questions if it is already shown' do
        expect(answer.hidden_questions).to_not include(:v_shown_and_hidden)
      end
      it 'removes the hidden questions keys from @hidden_questions if it is shown' do
        expect(answer.hidden_questions).to_not include(:v_hidden_and_shown)
      end
    end

    describe '#shown_questions' do
      it 'sets the @shown_questions attribute to the shown questions' do
        expect(answer.shown_questions).to include(:v_hidden_and_shown, :v_shown_and_hidden, :v_default_invisible_shown)
      end
    end

    describe '#question_groups' do
      it 'sets the @question_groups attribute to a hash of the question groups' do
        expect(answer.question_groups).to eq(
            {group1: [:v_answer_group_under_minimum, :v_answer_group_under_minimum1],
             group2: [:v_answer_group_over_minimum, :v_answer_group_over_minimum1],
             group3: [:v_answer_group_under_maximum, :v_answer_group_under_maximum1],
             group4: [:v_answer_group_over_maximum, :v_answer_group_over_maximum1],
             cgroup1: [:v_check_answer_group_under_minimum, :v_check_answer_group_under_minimum1],
             cgroup2: [:v_check_answer_group_over_minimum, :v_check_answer_group_over_minimum1],
             cgroup3: [:v_check_answer_group_under_maximum, :v_check_answer_group_under_maximum1],
             cgroup4: [:v_check_answer_group_over_maximum, :v_check_answer_group_over_maximum1]
            }
        )
      end
    end

    describe '#cleanup_input' do
      before do
        answer.cleanup_input
      end

      it 'clears placeholder answers' do
        expect(answer.v_placeholder).to be_nil
      end

      it 'clears answers of questions that are being hidden' do
        expect(answer.v_hidden).to be_nil
      end

      it 'does not clear answers of questions that are being hidden and shown at the same time' do
        expect(answer.v_hidden_and_shown).to eq "a0"
      end

      it 'clears answers of questions that are default invisible and not shown' do
        expect(answer.v_default_invisible).to be_nil
      end

      it 'does not clear answers of questions that are default invisible that are shown' do
        expect(answer.v_default_invisible_shown).to eq "a0"
      end

      it 'clears answers of questions where the parent option is not selected' do
        expect(answer.v_child).to be_nil
      end

      it 'skips questions that have the :hidden type (deprecated questions)' do
        expect(answer.v_hidden_type).to eq "a0"
      end

      it 'does not clear questions that depend on unfilled questions' do
        expect(answer.v_depends_on).to eq "a0"
      end

      it 'does not clear checkbox questions' do
        expect(answer.v_check_box).to eq("v_c1" => 0, "v_c2" => 1, "v_c3" => 1)
        expect(answer.v_c1).to eq 0
        expect(answer.v_c2).to eq 1
        expect(answer.v_c3).to eq 1
      end

      it 'converts windows line ends to linux line ends' do
        answer.v_textarea = "foo\r\nbar"
        answer.cleanup_input
        expect(answer.v_textarea).to eq("foo\nbar")
      end
    end

    describe '#validate_answers' do
      describe 'if the questionnaire was not aborted' do
        before do
          answer.cleanup_input
          answer.validate_answers
        end

        it 'skips validating questions that depend on unfilled questions' do
          expect(answer.errors.messages[:v_depends_on2]).to be_nil
        end

        it 'adds an error if integers are formatted incorrectly' do
          expect(answer.errors.messages[:v_invalid_integer])
              .to eq([{message: "Invalid integer", valtype: :valid_integer}])
        end

        it 'does not add an error if integers are formatted correctly' do
          expect(answer.errors.messages[:v_valid_integer])
              .to_not eq([{message: "Invalid integer", valtype: :valid_integer}])
        end

        it 'adds an error if floats are formatted incorrectly' do
          expect(answer.errors.messages[:v_invalid_float])
              .to eq([{message: "Invalid float", valtype: :valid_float}])
        end

        it 'does not add an error if floats are formatted correctly' do
          expect(answer.errors.messages[:v_valid_float])
              .to_not eq([{message: "Invalid float", valtype: :valid_float}])
        end

        it 'adds an error if an answer doesnt match a given regex' do
          expect(answer.errors.messages[:v_invalid_regexp])
              .to eq([{message: "Does not match expected pattern.", valtype: :regexp}])
        end

        it 'does not add an error if an answer matches a given regex' do
          expect(answer.errors.messages[:v_valid_regexp])
              .to_not eq([{message: "Does not match expected_pattern.", valtype: :regexp}])
        end

        it 'adds an error if a required question is unfilled' do
          expect(answer.errors.messages[:v_required])
              .to eq([{message: "Must be answered.", valtype: :requires_answer}])
        end

        it 'does not add an error if a required question is a child of an unchecked option' do
          expect(answer.errors.messages[:v_child])
              .to_not eq([{message: "Must be answered.", valtype: :requires_answer}])
        end

        it 'adds an error if a child of a filled option of a required question is not filled' do
          expect(answer.errors.messages[:v_child2])
              .to eq([{message: "Must be answered.", valtype: :requires_answer}])
        end

        it 'does not adds an error if a required question is filled' do
          expect(answer.errors.messages[:v_valid_required])
              .to_not eq([{message: "Must be answered.", valtype: :requires_answer}])
        end

        it 'adds an error if a value is under a given minimum' do
          expect(answer.errors.messages[:v_under_minimum])
              .to eq([{message: "Smaller than minimum", valtype: :minimum}])
        end

        it 'does not add an error if a value is over a given minimum' do
          expect(answer.errors.messages[:v_over_minimum])
              .to_not eq([{message: "Smaller than minimum", valtype: :minimum}])
        end

        it 'adds an error if a value exceeds given maximum' do
          expect(answer.errors.messages[:v_over_maximum])
              .to eq([{message: "Exceeds maximum", valtype: :maximum}])
        end

        it 'does not add an error if a value is under a given maximum' do
          expect(answer.errors.messages[:v_under_maximum])
              .to_not eq([{message: "Exceeds maximum", valtype: :maximum}])
        end

        it 'adds an error if too many checkbox options are checked' do
          expect(answer.errors.messages[:v_too_many_checked])
              .to eq([{message: "Invalid combination of options.", valtype: :too_many_checked}])
        end

        it 'does not add an error if not too many checkbox options are checked' do
          expect(answer.errors.messages[:v_not_too_many_checked])
              .to_not eq([{message: "Invalid combination of options.", valtype: :too_many_checked}])
        end

        it 'adds an error if not enough checkbox options are checked' do
          expect(answer.errors.messages[:v_not_all_checked])
              .to eq([{message: "Invalid combination of options.", valtype: :not_all_checked}])
        end

        it 'does not add an error if enough checkbox options are checked' do
          expect(answer.errors.messages[:v_all_checked])
              .to_not eq([{message: "Invalid combination of options.", valtype: :not_all_checked}])
        end

        it 'adds an error if not enough answers are in a question group with a minimum' do
          expect(answer.errors.messages[:v_answer_group_under_minimum])
              .to eq([{message: "Needs at least 1 question(s) answered.", valtype: :answer_group_minimum}])
        end

        it 'does not add an error if enough answers are in a question group with a minimum' do
          expect(answer.errors.messages[:v_answer_group_over_minimum])
              .to_not eq([{message: "Needs at least 1 question(s) answered.", valtype: :answer_group_minimum}])
        end

        it 'adds an error if too many answers are in a question group with a maximum' do
          expect(answer.errors.messages[:v_answer_group_over_maximum])
              .to eq([{message: "Needs at most 1 question(s) answered.", valtype: :answer_group_maximum}])
        end

        it 'does not add an error if not too many answers are in a question group with a maximum' do
          expect(answer.errors.messages[:v_answer_group_under_maximum])
              .to_not eq([{message: "Needs at most 1 question(s) answered.", valtype: :answer_group_maximum}])
        end

        describe 'for checkboxes' do
          it 'adds an error if not enough answers are in a question group with a minimum' do
            expect(answer.errors.messages[:v_check_answer_group_under_minimum])
                .to eq([{message: "Needs at least 3 question(s) answered.", valtype: :answer_group_minimum}])
          end

          it 'does not add an error if enough answers are in a question group with a minimum' do
            expect(answer.errors.messages[:v_check_answer_group_over_minimum]).to be_nil
          end

          it 'adds an error if too many answers are in a question group with a maximum' do
            expect(answer.errors.messages[:v_check_answer_group_over_maximum])
                .to eq([{message: "Needs at most 1 question(s) answered.", valtype: :answer_group_maximum}])
          end

          it 'does not add an error if not too many answers are in a question group with a maximum' do
            expect(answer.errors.messages[:v_check_answer_group_under_maximum]).to be_nil
          end

          it 'adds an error on an empty required title question if a depended on checkbox option is checked' do
            expect(answer.errors.messages[:v_depend_title]).to eq([{message: "Must be answered.",
                                                                    valtype: :requires_answer}])
          end

          it 'does not add error on an empty required title question if a depended on checkbox option is unchecked' do
            expect(answer.errors.messages[:v_depend2_title]).to eq(nil)
          end
        end
      end

      describe 'if the questionnaire was aborted' do
        before do
          allow(answer).to receive(:aborted).and_return(true)
          answer.cleanup_input
          answer.validate_answers
        end
        it 'skips all validations' do
          expect(answer.errors).to be_empty
        end
      end
    end
  end
end

# frozen_string_literal: true

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
        "v_date_range_under_minimum_yyyy" => '2017',
        "v_date_range_under_minimum_mm" => '1',
        "v_date_range_under_minimum_dd" => '1',
        "v_date_range_on_minimum_yyyy" => '2017',
        "v_date_range_on_minimum_mm" => '1',
        "v_date_range_on_minimum_dd" => '2',
        "v_date_range_over_maximum_yyyy" => '2017',
        "v_date_range_over_maximum_mm" => '3',
        "v_date_range_over_maximum_dd" => '5',
        "v_date_range_on_maximum_yyyy" => '2017',
        "v_date_range_on_maximum_mm" => '3',
        "v_date_range_on_maximum_dd" => '4',
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
        answer.hidden_questions.should include(:v_hidden)
      end
      it 'does not add the hidden questions keys to @hidden_questions if it is already shown' do
        answer.hidden_questions.should_not include(:v_shown_and_hidden)
      end
      it 'removes the hidden questions keys from @hidden_questions if it is shown' do
        answer.hidden_questions.should_not include(:v_hidden_and_shown)
      end
    end

    describe '#shown_questions' do
      it 'sets the @shown_questions attribute to the shown questions' do
        answer.shown_questions.should include(:v_hidden_and_shown, :v_shown_and_hidden, :v_default_invisible_shown)
      end
    end

    describe '#question_groups' do
      it 'sets the @question_groups attribute to a hash of the question groups' do
        answer.question_groups.should ==
            {group1: [:v_answer_group_under_minimum, :v_answer_group_under_minimum1],
             group2: [:v_answer_group_over_minimum, :v_answer_group_over_minimum1],
             group3: [:v_answer_group_under_maximum, :v_answer_group_under_maximum1],
             group4: [:v_answer_group_over_maximum, :v_answer_group_over_maximum1],
             cgroup1: [:v_check_answer_group_under_minimum, :v_check_answer_group_under_minimum1],
             cgroup2: [:v_check_answer_group_over_minimum, :v_check_answer_group_over_minimum1],
             cgroup3: [:v_check_answer_group_under_maximum, :v_check_answer_group_under_maximum1],
             cgroup4: [:v_check_answer_group_over_maximum, :v_check_answer_group_over_maximum1]
            }
      end
    end

    describe '#cleanup_input' do
      before do
        answer.cleanup_input
      end

      it 'clears placeholder answers' do
        answer.v_placeholder.should be_nil
      end

      it 'clears answers of questions that are being hidden' do
        answer.v_hidden.should be_nil
      end

      it 'does not clear answers of questions that are being hidden and shown at the same time' do
        answer.v_hidden_and_shown.should == "a0"
      end

      it 'clears answers of questions that are default invisible and not shown' do
        answer.v_default_invisible.should be_nil
      end

      it 'does not clear answers of questions that are default invisible that are shown' do
        answer.v_default_invisible_shown.should == "a0"
      end

      it 'clears answers of questions where the parent option is not selected' do
        answer.v_child.should be_nil
      end

      it 'skips questions that have the :hidden type (deprecated questions)' do
        answer.v_hidden_type.should == "a0"
      end

      it 'does not clear questions that depend on unfilled questions' do
        answer.v_depends_on.should == "a0"
      end

      it 'does not clear checkbox questions' do
        answer.v_check_box.should eq("v_c1" => 0, "v_c2" => 1, "v_c3" => 1)
        answer.v_c1.should eq 0
        answer.v_c2.should eq 1
        answer.v_c3.should eq 1
      end

      it 'converts windows line ends to linux line ends' do
        answer.v_textarea = "foo\r\nbar"
        answer.cleanup_input
        answer.v_textarea.should eq("foo\nbar")
      end
    end

    describe '#validate_answers' do
      describe 'if the questionnaire was not aborted' do
        before do
          answer.cleanup_input
          answer.validate_answers
        end

        it 'skips validating questions that depend on unfilled questions' do
          answer.errors.messages[:v_depends_on2].should be_blank
        end

        it 'adds an error if integers are formatted incorrectly' do
          answer.errors.messages[:v_invalid_integer].should ==
              [{message: "Invalid integer", valtype: :valid_integer}]
        end

        it 'does not add an error if integers are formatted correctly' do
          answer.errors.messages[:v_valid_integer].should_not ==
              [{message: "Invalid integer", valtype: :valid_integer}]
        end

        it 'adds an error if floats are formatted incorrectly' do
          answer.errors.messages[:v_invalid_float].should ==
              [{message: "Invalid float", valtype: :valid_float}]
        end

        it 'does not add an error if floats are formatted correctly' do
          answer.errors.messages[:v_valid_float].should_not ==
              [{message: "Invalid float", valtype: :valid_float}]
        end

        it 'adds an error if an answer doesnt match a given regex' do
          answer.errors.messages[:v_invalid_regexp].should ==
              [{message: "Does not match expected pattern.", valtype: :regexp}]
        end

        it 'does not add an error if an answer matches a given regex' do
          answer.errors.messages[:v_valid_regexp].should_not ==
              [{message: "Does not match expected_pattern.", valtype: :regexp}]
        end

        it 'adds an error if a required question is unfilled' do
          answer.errors.messages[:v_required].should ==
              [{message: "Must be answered.", valtype: :requires_answer}]
        end

        it 'does not add an error if a required question is a child of an unchecked option' do
          answer.errors.messages[:v_child].should_not ==
              [{message: "Must be answered.", valtype: :requires_answer}]
        end

        it 'adds an error if a child of a filled option of a required question is not filled' do
          answer.errors.messages[:v_child2].should ==
              [{message: "Must be answered.", valtype: :requires_answer}]
        end

        it 'does not adds an error if a required question is filled' do
          answer.errors.messages[:v_valid_required].should_not ==
              [{message: "Must be answered.", valtype: :requires_answer}]
        end

        it 'adds an error if a value is under a given minimum' do
          answer.errors.messages[:v_under_minimum].should ==
              [{message: "Smaller than minimum", valtype: :minimum}]
        end

        it 'does not add an error if a value is over a given minimum' do
          answer.errors.messages[:v_over_minimum].should_not ==
              [{message: "Smaller than minimum", valtype: :minimum}]
        end

        it 'adds an error if a value exceeds given maximum' do
          answer.errors.messages[:v_over_maximum].should ==
              [{message: "Exceeds maximum", valtype: :maximum}]
        end

        it 'does not add an error if a value is under a given maximum' do
          answer.errors.messages[:v_under_maximum].should_not ==
              [{message: "Exceeds maximum", valtype: :maximum}]
        end

        it 'adds an error if a date exceeds given maximum' do
          answer.errors.messages[:v_date_range_over_maximum].should ==
            [{message: "Exceeds maximum", valtype: :maximum}]
        end

        it 'does not add an error if a date is on a given maximum' do
          answer.errors.messages[:v_date_range_on_maximum].should_not ==
            [{message: "Exceeds maximum", valtype: :maximum}]
        end

        it 'adds an error if a date is under a given minimum' do
          answer.errors.messages[:v_date_range_under_minimum].should ==
            [{message: "Smaller than minimum", valtype: :minimum}]
        end

        it 'does not add an error if a date is on a given minimum' do
          answer.errors.messages[:v_date_range_on_minimum].should_not ==
            [{message: "Smaller than minimum", valtype: :minimum}]
        end

        it 'adds an error if too many checkbox options are checked' do
          answer.errors.messages[:v_too_many_checked].should ==
              [{message: "Invalid combination of options.", valtype: :too_many_checked}]
        end

        it 'does not add an error if not too many checkbox options are checked' do
          answer.errors.messages[:v_not_too_many_checked].should_not ==
              [{message: "Invalid combination of options.", valtype: :too_many_checked}]
        end

        it 'adds an error if not enough checkbox options are checked' do
          answer.errors.messages[:v_not_all_checked].should ==
              [{message: "Invalid combination of options.", valtype: :not_all_checked}]
        end

        it 'does not add an error if enough checkbox options are checked' do
          answer.errors.messages[:v_all_checked].should_not ==
              [{message: "Invalid combination of options.", valtype: :not_all_checked}]
        end

        it 'adds an error if not enough answers are in a question group with a minimum' do
          answer.errors.messages[:v_answer_group_under_minimum].should ==
              [{message: "Needs at least 1 question(s) answered.", valtype: :answer_group_minimum}]
        end

        it 'does not add an error if enough answers are in a question group with a minimum' do
          answer.errors.messages[:v_answer_group_over_minimum].should_not ==
              [{message: "Needs at least 1 question(s) answered.", valtype: :answer_group_minimum}]
        end

        it 'adds an error if too many answers are in a question group with a maximum' do
          answer.errors.messages[:v_answer_group_over_maximum].should ==
              [{message: "Needs at most 1 question(s) answered.", valtype: :answer_group_maximum}]
        end

        it 'does not add an error if not too many answers are in a question group with a maximum' do
          answer.errors.messages[:v_answer_group_under_maximum].should_not ==
              [{message: "Needs at most 1 question(s) answered.", valtype: :answer_group_maximum}]
        end

        describe 'for checkboxes' do
          it 'adds an error if not enough answers are in a question group with a minimum' do
            answer.errors.messages[:v_check_answer_group_under_minimum].should ==
                [{message: "Needs at least 3 question(s) answered.", valtype: :answer_group_minimum}]
          end

          it 'does not add an error if enough answers are in a question group with a minimum' do
            answer.errors.messages[:v_check_answer_group_over_minimum].should be_blank
          end

          it 'adds an error if too many answers are in a question group with a maximum' do
            answer.errors.messages[:v_check_answer_group_over_maximum].should ==
                [{message: "Needs at most 1 question(s) answered.", valtype: :answer_group_maximum}]
          end

          it 'does not add an error if not too many answers are in a question group with a maximum' do
            answer.errors.messages[:v_check_answer_group_under_maximum].should be_blank
          end

          it 'adds an error on an empty required title question if a depended on checkbox option is checked' do
            expect(answer.errors.messages[:v_depend_title]).to eq([{message: "Must be answered.",
                                                                    valtype: :requires_answer}])
          end

          it 'does not add error on an empty required title question if a depended on checkbox option is unchecked' do
            expect(answer.errors.messages[:v_depend2_title]).to be_blank
          end
        end
      end

      describe 'if the questionnaire was aborted' do
        before do
          answer.stub(aborted: true)
          answer.cleanup_input
          answer.validate_answers
        end
        it 'skips all validations' do
          answer.errors.should be_empty
        end
      end
    end
  end
end

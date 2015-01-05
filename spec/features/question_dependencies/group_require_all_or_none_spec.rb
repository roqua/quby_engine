require 'spec_helper'

shared_examples 'group_require_all_or_none_tests' do
  it 'is valid when np question is filled in' do
    run_validations
    expect_no_errors
  end

  it 'is invalid when only radio question filled in' do
    select_radio_option 'v_radio', 'a1'
    run_validations
    expect_errors_on_group
  end

  it 'is invalid when only scale question filled in' do
    select_radio_option 'v_scale', 'a1'
    run_validations
    expect_errors_on_group
  end

  it 'is invalid when only select question filled in' do
    select_select_option 'v_select', 'a1'
    run_validations
    expect_errors_on_group
  end

  it 'is invalid when only check_box question filled in' do
    check_option 'v_ck_a1'
    uncheck_option 'v_ck_a2'
    run_validations
    expect_errors_on_group
  end

  it 'is invalid when only string question filled in' do
    fill_in_question 'v_string', 'kittens!'
    run_validations
    expect_errors_on_group
  end

  it 'is invalid when only integer question filled in' do
    fill_in_question 'v_integer', '37'
    run_validations
    expect_errors_on_group
  end

  it 'is invalid when only float question filled in' do
    fill_in_question 'v_float', '4.2'
    run_validations
    expect_errors_on_group
  end

  it 'is invalid when only date question filled in' do
    fill_in_question('v_date_year',  '2013')
    fill_in_question('v_date_month', '12')
    fill_in_question('v_date_day',   '10')
    run_validations
    expect_errors_on_group
  end

  it 'is invalid when only radio question is not filled' do
    # select_radio_option 'v_radio', 'a1'
    select_radio_option 'v_scale', 'a1'
    select_select_option 'v_select', 'a1'
    check_option 'v_ck_a1'
    uncheck_option 'v_ck_a2'
    fill_in_question 'v_string', 'kittens!'
    fill_in_question 'v_integer', '37'
    fill_in_question 'v_float', '4.2'
    fill_in_question('v_date_year',  '2013')
    fill_in_question('v_date_month', '12')
    fill_in_question('v_date_day',   '10')
    run_validations
    expect_errors_on_group
  end

  it 'is invalid when only scale question is not filled' do
    select_radio_option 'v_radio', 'a1'
    # select_radio_option 'v_scale', 'a1'
    select_select_option 'v_select', 'a1'
    check_option 'v_ck_a1'
    uncheck_option 'v_ck_a2'
    fill_in_question 'v_string', 'kittens!'
    fill_in_question 'v_integer', '37'
    fill_in_question 'v_float', '4.2'
    fill_in_question('v_date_year',  '2013')
    fill_in_question('v_date_month', '12')
    fill_in_question('v_date_day',   '10')
    run_validations
    expect_errors_on_group
  end

  it 'is invalid when only select question is not filled' do
    select_radio_option 'v_radio', 'a1'
    select_radio_option 'v_scale', 'a1'
    # select_select_option 'v_select', 'a1'
    check_option 'v_ck_a1'
    uncheck_option 'v_ck_a2'
    fill_in_question 'v_string', 'kittens!'
    fill_in_question 'v_integer', '37'
    fill_in_question 'v_float', '4.2'
    fill_in_question('v_date_year',  '2013')
    fill_in_question('v_date_month', '12')
    fill_in_question('v_date_day',   '10')
    run_validations
    expect_errors_on_group
  end

  it 'is invalid when only check_box question is not filled' do
    select_radio_option 'v_radio', 'a1'
    select_radio_option 'v_scale', 'a1'
    select_select_option 'v_select', 'a1'
    # check_option 'v_ck_a1'
    # uncheck_option 'v_ck_a2'
    fill_in_question 'v_string', 'kittens!'
    fill_in_question 'v_integer', '37'
    fill_in_question 'v_float', '4.2'
    fill_in_question('v_date_year',  '2013')
    fill_in_question('v_date_month', '12')
    fill_in_question('v_date_day',   '10')
    run_validations
    expect_errors_on_group
  end

  it 'is invalid when only string question is not filled' do
    select_radio_option 'v_radio', 'a1'
    select_radio_option 'v_scale', 'a1'
    select_select_option 'v_select', 'a1'
    check_option 'v_ck_a1'
    uncheck_option 'v_ck_a2'
    # fill_in_question 'v_string', 'kittens!'
    fill_in_question 'v_integer', '37'
    fill_in_question 'v_float', '4.2'
    fill_in_question('v_date_year',  '2013')
    fill_in_question('v_date_month', '12')
    fill_in_question('v_date_day',   '10')
    run_validations
    expect_errors_on_group
  end

  it 'is invalid when only integer question is not filled' do
    select_radio_option 'v_radio', 'a1'
    select_radio_option 'v_scale', 'a1'
    select_select_option 'v_select', 'a1'
    check_option 'v_ck_a1'
    uncheck_option 'v_ck_a2'
    fill_in_question 'v_string', 'kittens!'
    # fill_in_question 'v_integer', '37'
    fill_in_question 'v_float', '4.2'
    fill_in_question('v_date_year',  '2013')
    fill_in_question('v_date_month', '12')
    fill_in_question('v_date_day',   '10')
    run_validations
    expect_errors_on_group
  end

  it 'is invalid when only float question is not filled' do
    select_radio_option 'v_radio', 'a1'
    select_radio_option 'v_scale', 'a1'
    select_select_option 'v_select', 'a1'
    check_option 'v_ck_a1'
    uncheck_option 'v_ck_a2'
    fill_in_question 'v_string', 'kittens!'
    fill_in_question 'v_integer', '37'
    # fill_in_question 'v_float', '4.2'
    fill_in_question('v_date_year',  '2013')
    fill_in_question('v_date_month', '12')
    fill_in_question('v_date_day',   '10')
    run_validations
    expect_errors_on_group
  end

  it 'is invalid when only date question is not filled' do
    select_radio_option 'v_radio', 'a1'
    select_radio_option 'v_scale', 'a1'
    select_select_option 'v_select', 'a1'
    check_option 'v_ck_a1'
    uncheck_option 'v_ck_a2'
    fill_in_question 'v_string', 'kittens!'
    fill_in_question 'v_integer', '37'
    fill_in_question 'v_float', '4.2'
    # fill_in_question('v_date_year',  '2013')
    # fill_in_question('v_date_month', '12')
    # fill_in_question('v_date_day',   '10')
    run_validations
    expect_errors_on_group
  end

  it 'is valid when all questions are filled in' do
    select_radio_option 'v_radio', 'a1'
    select_radio_option 'v_scale', 'a1'
    select_select_option 'v_select', 'a1'
    check_option 'v_ck_a1'
    uncheck_option 'v_ck_a2'
    fill_in_question 'v_string', 'kittens!'
    fill_in_question 'v_integer', '37'
    fill_in_question 'v_float', '4.2'
    fill_in_question('v_date_year',  '2013')
    fill_in_question('v_date_month', '12')
    fill_in_question('v_date_day',   '10')
    run_validations
    expect_no_errors
    expect_saved_value 'v_radio', 'a1'
    expect_saved_value 'v_scale', 'a1'
    expect_saved_value 'v_select', 'a1'
    expect_saved_value 'v_check_box', {'v_ck_a1' => 1, 'v_ck_a2' => 0}
    expect_saved_value 'v_string', 'kittens!'
    expect_saved_value 'v_integer', "37"
    expect_saved_value 'v_float', "4.2"
    expect_saved_value 'v_date_year', "2013"
    expect_saved_value 'v_date_month', "12"
    expect_saved_value 'v_date_day', "10"
  end
end

shared_examples 'group_require_all_or_none' do
  context 'require all or none of the questions answered in a group' do
    let(:questionnaire) do
      inject_questionnaire 'test', <<-END
        panel do
          question :v_radio, type: :radio, question_group: :group1, group_require_all_or_none: true do
            title 'Radio Question'
            option :a1, value: 1, description: "Radio Option 1"
            option :a2, value: 2, description: "Radio Option 2"
          end

          question :v_scale, type: :scale, question_group: :group1, group_require_all_or_none: true do
            title 'Scale Question'
            option :a1, value: 1, description: "Scale Option 1"
            option :a2, value: 2, description: "Scale Option 2"
          end

          question :v_select, type: :select, question_group: :group1, group_require_all_or_none: true do
            title 'Select Question'
            option :a0, value: 0, description: "--- Kies ---", placeholder: true
            option :a1, value: 1, description: "Select Option 1"
            option :a2, value: 2, description: "Select Option 2"
          end

          question :v_check_box, type: :check_box, question_group: :group1, group_require_all_or_none: true do
            title "Pick one"
            option :v_ck_a1, value: 1, description: 'Unicorns'
            option :v_ck_a2, value: 2, description: 'Rainbows'
          end

          question :v_string, type: :string, question_group: :group1, group_require_all_or_none: true do
            title 'String Question'
          end

          question :v_integer, type: :integer, question_group: :group1, group_require_all_or_none: true do
            title 'Integer Question'
          end

          question :v_float, type: :float, question_group: :group1, group_require_all_or_none: true do
            title 'Float Question'
          end

          question :v_date, type: :date, question_group: :group1, group_require_all_or_none: true,
                            year_key: :v_date_year, month_key: :v_date_month, day_key: :v_date_day do
            title "Enter a date"
          end
        end; end_panel
      END
    end

    it_behaves_like 'group_require_all_or_none_tests'
  end

  context 'maximum number of given answers in a group, with a table in the mix' do
    let(:questionnaire) do
      inject_questionnaire 'test', <<-END
        panel do
          table columns: 20 do
            question :v_radio, type: :radio, question_group: :group1, group_require_all_or_none: true do
              title 'Radio Question'
              option :a1, value: 1, description: "Radio Option 1"
              option :a2, value: 2, description: "Radio Option 2"
            end

            question :v_scale, type: :scale, question_group: :group1, group_require_all_or_none: true do
              title 'Scale Question'
              option :a1, value: 1, description: "Scale Option 1"
              option :a2, value: 2, description: "Scale Option 2"
            end

            question :v_select, type: :select, question_group: :group1, group_require_all_or_none: true do
              title 'Select Question'
              option :a0, value: 0, description: "--- Kies ---", placeholder: true
              option :a1, value: 1, description: "Select Option 1"
              option :a2, value: 2, description: "Select Option 2"
            end

            question :v_check_box, type: :check_box, question_group: :group1, group_require_all_or_none: true do
              title "Pick one"
              option :v_ck_a1, value: 1, description: 'Unicorns'
              option :v_ck_a2, value: 2, description: 'Rainbows'
            end

            question :v_string, type: :string, question_group: :group1, group_require_all_or_none: true do
              title 'String Question'
            end

            question :v_integer, type: :integer, question_group: :group1, group_require_all_or_none: true do
              title 'Integer Question'
            end

            question :v_float, type: :float, question_group: :group1, group_require_all_or_none: true do
              title 'Float Question'
            end

            question :v_date, type: :date, question_group: :group1, group_require_all_or_none: true,
                              year_key: :v_date_year, month_key: :v_date_month, day_key: :v_date_day do
              title "Enter a date"
            end
          end
        end; end_panel
      END
    end

    it_behaves_like 'group_require_all_or_none_tests'
  end

  context 'with hidden questions in the mix' do
    let(:questionnaire) do
      inject_questionnaire 'test', <<-END
        panel do
          question :v_radio, type: :radio, question_group: :grp1, group_require_all_or_none: true do
            title 'Radio Question'
            option :a1, value: 1, description: "Radio Option 1"
            option :a2, value: 2, description: "Radio Option 2"
          end

          question :v_scale, type: :scale, default_invisible: true, question_group: :grp1,
                             group_require_all_or_none: true do
            title 'Scale Question'
            option :a1, value: 1, description: "Scale Option 1"
            option :a2, value: 2, description: "Scale Option 2"
          end

          question :v_select, type: :select, question_group: :grp1, group_require_all_or_none: true do
            title 'Select Question'
            option :a0, value: 0, description: "--- Kies ---", placeholder: true
            option :a1, value: 1, description: "Select Option 1"
            option :a2, value: 2, description: "Select Option 2"
          end
        end; end_panel
      END
    end

    it 'does not count hidden as unanswered' do
      select_radio_option 'v_radio', 'a1'
      select_select_option 'v_select', 'a1'
      run_validations
      expect_no_errors
    end

    it 'does not count hidden as answered' do
      run_validations
      expect_no_errors
    end
  end

  def expect_errors_on_group
    expect_error_on 'v_radio', 'answer_group_require_all_or_none'
    expect_error_on 'v_scale', 'answer_group_require_all_or_none'
    expect_error_on 'v_select', 'answer_group_require_all_or_none'
    expect_error_on 'v_check_box', 'answer_group_require_all_or_none'
    expect_error_on 'v_string', 'answer_group_require_all_or_none'
    expect_error_on 'v_integer', 'answer_group_require_all_or_none'
    expect_error_on 'v_float', 'answer_group_require_all_or_none'
    expect_error_on 'v_date', 'answer_group_require_all_or_none'
  end
end

feature 'Client-side validations for group require all or none', js: true do
  include ClientSideValidationHelpers
  it_behaves_like "group_require_all_or_none"
end

feature 'Server-side validations for group require all or none' do
  include ServerSideValidationHelpers
  it_behaves_like "group_require_all_or_none"
end

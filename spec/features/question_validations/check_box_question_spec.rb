require 'spec_helper'

shared_examples 'validations on checkbox questions' do
  context 'requires_answer validation' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_check_box, type: :check_box, required: true do
          title "Pick one"
          option :v_ck_a1, value: 1, description: 'Unicorns'
          option :v_ck_a2, value: 2, description: 'Rainbows'
        end; end_panel
      END
    end

    scenario 'saving a valid choice' do
      check_option 'v_ck_a1'
      check_option 'v_ck_a2'
      run_validations
      expect_no_errors
      expect_saved_value 'v_check_box', {'v_ck_a1' => 1, 'v_ck_a2' => 1}
    end

    scenario 'saving a single option checked' do
      check_option   'v_ck_a1'
      uncheck_option 'v_ck_a2'
      run_validations
      expect_no_errors
      expect_saved_value 'v_check_box', {'v_ck_a1' => 1, 'v_ck_a2' => 0}
    end

    scenario 'saving without a choice' do
      run_validations
      expect_error_on 'v_check_box', 'requires_answer'
    end
  end

  context 'too_many_checked' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_check_box, type: :check_box, uncheck_all_option: :v_ck_a3 do
          title "Pick one"
          option :v_ck_a1, value: 1, description: 'Unicorns'
          option :v_ck_a2, value: 2, description: 'Rainbows'
          option :v_ck_a3, value: 3, description: 'None'
        end; end_panel
      END
    end

    scenario 'saving a valid choice' do
      # Clientside JS scripts will auto-deselect a1 when a3 is selected. The server
      # assumes the value it receives is correct and does not perform this deselect-trick again.
      next if validation_run_location == :server_side

      check_option 'v_ck_a1'
      check_option 'v_ck_a3'
      run_validations
      expect_no_errors
      expect_saved_value 'v_check_box', {"v_ck_a1" => 0, "v_ck_a2" => 0, 'v_ck_a3' => 1}
    end
  end

  context 'not_all_checked' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_check_box, type: :check_box, check_all_option: :v_ck_a3 do
          title "Pick one"
          option :v_ck_a1, value: 1, description: 'Unicorns'
          option :v_ck_a2, value: 2, description: 'Rainbows'
          option :v_ck_a3, value: 3, description: 'All'
        end; end_panel
      END
    end

    scenario 'is valid when everything is checked' do
      check_option 'v_ck_a1'
      check_option 'v_ck_a2'
      check_option 'v_ck_a3'
      run_validations
      expect_no_errors
      expect_saved_value 'v_check_box', {"v_ck_a1" => 1, "v_ck_a2" => 1, 'v_ck_a3' => 1}
    end

    scenario 'is valid when some things are checked as long as All is not checked' do
      check_option   'v_ck_a1'
      uncheck_option 'v_ck_a2'
      uncheck_option 'v_ck_a3'
      run_validations
      expect_no_errors
      expect_saved_value 'v_check_box', {"v_ck_a1" => 1, "v_ck_a2" => 0, 'v_ck_a3' => 0}
    end

    scenario 'is valid when everything but the All option is checked' do
      check_option   'v_ck_a1'
      check_option   'v_ck_a2'
      uncheck_option 'v_ck_a3'
      run_validations
      expect_no_errors
      expect_saved_value 'v_check_box', {"v_ck_a1" => 1, "v_ck_a2" => 1, 'v_ck_a3' => 0}
    end

    scenario 'is not valid when All is checked but not all other options are checked' do
      # Clientside, JS scripts will auto-deselect a3 when a2 is deselected, so this
      # situation should not be possible to submit.
      next if validation_run_location == :client_side

      check_option   'v_ck_a1'
      check_option   'v_ck_a3'
      uncheck_option 'v_ck_a2'
      run_validations
      expect_error_on 'v_check_box', 'not_all_checked'
    end
  end

  context 'question groups' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        panel do
table columns: 4 do
question :v_check_answer_group_under_minimum, question_group: :cgroup1, group_minimum_answered: 3, type: :check_box do
  option :v_check_answer_group_under_minimum_a1
  option :v_check_answer_group_under_minimum_a2
end
question :v_check_answer_group_under_minimum1, question_group: :cgroup1, group_minimum_answered: 3, type: :check_box do
  option :v_check_answer_group_under_minimum1_a1
  option :v_check_answer_group_under_minimum1_a2
end
question :v_check_answer_group_over_minimum, question_group: :cgroup2, group_minimum_answered: 1, type: :check_box do
  option :v_check_answer_group_over_minimum_a1
  option :v_check_answer_group_over_minimum_a2
end
question :v_check_answer_group_over_minimum1, question_group: :cgroup2, group_minimum_answered: 1, type: :check_box do
  option :v_check_answer_group_over_minimum1_a1
  option :v_check_answer_group_over_minimum1_a2
end
question :v_check_answer_group_under_maximum, question_group: :cgroup3, group_maximum_answered: 2, type: :check_box do
  option :v_check_answer_group_under_maximum_a1
  option :v_check_answer_group_under_maximum_a2
end
question :v_check_answer_group_under_maximum1, question_group: :cgroup3, group_maximum_answered: 2, type: :check_box do
  option :v_check_answer_group_under_maximum1_a1
  option :v_check_answer_group_under_maximum1_a2
end
question :v_check_answer_group_over_maximum, question_group: :cgroup4, group_maximum_answered: 1, type: :check_box do
  option :v_check_answer_group_over_maximum_a1
  option :v_check_answer_group_over_maximum_a2
end
question :v_check_answer_group_over_maximum1, question_group: :cgroup4, group_maximum_answered: 1, type: :check_box do
  option :v_check_answer_group_over_maximum1_a1
  option :v_check_answer_group_over_maximum1_a2
end
end; end; end_panel
      END
    end

    scenario 'shows errors for invalid fillings and not for valid fillings' do
      check_option "v_check_answer_group_under_minimum_a1"
      check_option "v_check_answer_group_under_minimum1_a2"
      check_option "v_check_answer_group_over_minimum_a1"
      check_option "v_check_answer_group_over_minimum1_a2"
      check_option "v_check_answer_group_under_maximum_a1"
      check_option "v_check_answer_group_under_maximum1_a2"
      check_option "v_check_answer_group_over_maximum_a1"
      check_option "v_check_answer_group_over_maximum1_a2"


      run_validations
      expect_error_on "v_check_answer_group_under_minimum", "answer_group_minimum"
      expect_no_error_on "v_check_answer_group_over_minimum"
      expect_no_error_on "v_check_answer_group_under_maximum"
      expect_error_on "v_check_answer_group_over_maximum", "answer_group_maximum"
    end
  end
end

feature 'Client-side validations on checkbox questions', js: true do
  include ClientSideValidationHelpers
  it_behaves_like "validations on checkbox questions"
end

feature 'Server-side validations on checkbox questions' do
  include ServerSideValidationHelpers
  it_behaves_like "validations on checkbox questions"
end

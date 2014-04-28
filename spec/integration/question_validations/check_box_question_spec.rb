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
      check_option 'v_ck_a1'
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
      pending 'serverside does not work'
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
      check_option 'v_ck_a1'
      run_validations
      expect_no_errors
      expect_saved_value 'v_check_box', {"v_ck_a1" => 1, "v_ck_a2" => 0, 'v_ck_a3' => 0}
    end

    scenario 'is valid when everything but the All option is checked' do
      check_option 'v_ck_a1'
      check_option 'v_ck_a2'
      run_validations
      expect_no_errors
      expect_saved_value 'v_check_box', {"v_ck_a1" => 1, "v_ck_a2" => 1, 'v_ck_a3' => 0}
    end

    scenario 'is not valid when All is checked but not all other options are checked' do
      check_option 'v_ck_a1'
      check_option 'v_ck_a3'
      run_validations
      expect_error_on 'v_check_box', 'not_all_checked'
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

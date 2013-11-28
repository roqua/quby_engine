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

    scenario 'saving without a choice' do
      run_validations
      expect_error_on 'v_check_box', 'requires_answer'
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
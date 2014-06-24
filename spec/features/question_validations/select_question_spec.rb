require 'spec_helper'

shared_examples 'validations on select questions' do
  context 'requires_answer validation' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_select, type: :select, required: true do
          title "Pick one"
          option :a0, value: 0, description: "--- Kies ---", placeholder: true
          option :a1, value: 1, description: 'Unicorns'
          option :a2, value: 2, description: 'Rainbows'
        end; end_panel
      END
    end

    scenario 'saving a valid choice' do
      select_select_option 'v_select', 'a1'
      run_validations
      expect_no_errors
      expect_saved_value 'v_select', 'a1'
    end

    scenario 'saving with an unknown select chosen' do
      next if validation_run_location == :client_side

      # TODO: Is this the behaviour we really want?
      select_select_option 'v_select', 'aXX'
      run_validations
      expect_no_errors
      expect_saved_value 'v_select', 'aXX'
    end

    scenario 'saving without a choice' do
      run_validations
      expect_error_on 'v_select', 'requires_answer'
    end

    scenario 'saving selecting the placeholder' do
      select_select_option 'v_select', 'a0'
      run_validations
      expect_error_on 'v_select', 'requires_answer'
    end
  end
end

feature 'Client-side validations on select questions', js: true do
  include ClientSideValidationHelpers
  it_behaves_like "validations on select questions"
end

feature 'Server-side validations on select questions' do
  include ServerSideValidationHelpers
  it_behaves_like "validations on select questions"
end

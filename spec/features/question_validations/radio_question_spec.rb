require 'spec_helper'

shared_examples 'validations on radio questions' do
  context 'requires_answer validation' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_radio, type: :radio, required: true, deselectable: true do
          title "Pick one"
          option :a1, value: 1, description: 'Unicorns'
          option :a2, value: 2, description: 'Rainbows'
        end; end_panel
      END
    end

    scenario 'saving a valid choice' do
      select_radio_option 'v_radio', 'a1'
      run_validations
      expect_no_errors
      expect_saved_value 'v_radio', 'a1'
    end

    scenario 'saving after deselecting the radio again' do
      select_radio_option 'v_radio', 'a1'
      deselect_radio_option 'v_radio', 'a1'
      run_validations
      expect_error_on 'v_radio', 'requires_answer'
    end

    scenario 'saving with an unknown radio chosen' do
      next if validation_run_location == :client_side

      # TODO: Is this the behaviour we really want?
      select_radio_option 'v_radio', 'aXX'
      run_validations
      expect_no_errors
      expect_saved_value 'v_radio', 'aXX'
    end

    scenario 'saving without a choice' do
      run_validations
      expect_error_on 'v_radio', 'requires_answer'
    end
  end
end

feature 'Client-side validations on radio questions', js: true do
  include ClientSideValidationHelpers
  it_behaves_like "validations on radio questions"
end

feature 'Server-side validations on radio questions' do
  include ServerSideValidationHelpers
  it_behaves_like 'validations on radio questions'
end

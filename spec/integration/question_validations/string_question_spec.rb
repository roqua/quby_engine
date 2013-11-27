require 'spec_helper'

shared_examples 'validations on string questions' do
  let(:questionnaire) do
    inject_questionnaire "test", <<-END
      question :v_string, type: :string, required: true do
        title "Enter a string"
      end; end_panel
    END
  end

  scenario 'saving a valid string' do
    fill_in_question 'v_string', 'kittens!'
    run_validations
    expect_no_errors
    expect_saved_value 'v_string', 'kittens!'
  end

  scenario 'saving without a string' do
    fill_in_question 'v_string', ''
    run_validations
    expect_error_on 'v_string', 'requires_answer'
  end
end

feature 'Client-side validations on string questions', js: true do
  include ClientSideValidationHelpers
  it_behaves_like "validations on string questions"
end

feature 'Server-side validations on string questions' do
  include ServerSideValidationHelpers
  it_behaves_like "validations on string questions"
end
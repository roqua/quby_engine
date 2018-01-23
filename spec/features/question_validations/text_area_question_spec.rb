require 'spec_helper'

shared_examples 'validations on textarea questions' do
  before do
    allow_server_side_validation_error
  end
  let(:questionnaire) do
    inject_questionnaire "test", <<-END
      question :v_textarea, type: :textarea, required: true do
        title "Enter a text"
      end; end_panel
    END
  end

  scenario 'saving a valid textarea' do
    fill_in_question 'v_textarea', "kittens!\nthey are cute"
    run_validations
    expect_no_errors
    expect_saved_value 'v_textarea', "kittens!\nthey are cute"
  end

  scenario 'saving without a textarea' do
    fill_in_question 'v_textarea', ''
    run_validations
    expect_error_on 'v_textarea', 'requires_answer'
  end
end

feature 'Client-side validations on textarea questions', js: true do
  include ClientSideValidationHelpers
  it_behaves_like "validations on textarea questions"
end

feature 'Server-side validations on textarea questions' do
  include ServerSideValidationHelpers
  it_behaves_like "validations on textarea questions"
end

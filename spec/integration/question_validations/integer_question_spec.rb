require 'spec_helper'

shared_examples "validations on integer questions" do
  context 'requires_answer validation' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_integer, type: :integer, required: true do
          title "Enter a integer"
        end; end_panel
      END
    end

    scenario 'saving a valid integer' do
      fill_in_question('v_integer', '1')
      run_validations
      expect_no_errors
      expect_saved_value 'v_integer', '1'
    end

    scenario 'saving a float into a integer field' do
      fill_in_question 'v_integer', '1.2'
      run_validations
      expect_error_on 'v_integer', 'valid_integer'
    end

    scenario 'saving an invalid integer' do
      fill_in_question 'v_integer', 'foo'
      run_validations
      expect_error_on 'v_integer', 'valid_integer'

      fill_in_question 'v_integer', ''
      run_validations
      expect_error_on 'v_integer', 'requires_answer'
    end
  end

  context 'in_range validation' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_integer, type: :integer do
          title "Enter a date"
          validates_in_range 10..20
        end; end_panel
      END
    end

    scenario 'saving a valid integer' do
      fill_in_question('v_integer', '15')
      run_validations
      expect_no_errors
    end

    scenario 'saving no integer' do
      fill_in_question('v_integer', '')
      run_validations
      expect_no_errors
    end

    scenario 'saving a too-low integer' do
      fill_in_question('v_integer', '5')
      run_validations
      expect_error_on 'v_integer', 'minimum'
    end

    scenario 'saving a too-high integer' do
      fill_in_question('v_integer', '25')
      run_validations
      expect_error_on 'v_integer', 'maximum'
    end

    scenario 'saving an invalid integer' do
      fill_in_question('v_integer', 'foo')
      run_validations
      expect_error_on 'v_integer', 'valid_integer'
    end
  end
end

feature 'Client-side validations on integer questions', js: true do
  include ClientSideValidationHelpers
  it_behaves_like "validations on integer questions"
end

feature 'Server-side validations on integer questions' do
  include ServerSideValidationHelpers
  it_behaves_like "validations on integer questions"
end
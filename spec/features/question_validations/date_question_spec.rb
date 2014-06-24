require 'spec_helper'

shared_examples 'validations on date questions' do
  context 'requires_answer validation' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_date, type: :date, required: true,
                          year_key: :v_date_year, month_key: :v_date_month, day_key: :v_date_day do
          title "Enter a date"
        end; end_panel
      END
    end

    scenario 'saving a valid date' do
      fill_in_question('v_date_year',  '2013')
      fill_in_question('v_date_month', '12')
      fill_in_question('v_date_day',   '10')
      run_validations
      expect_no_errors
      expect_saved_value 'v_date', '10-12-2013'
    end

    scenario 'saving without a date' do
      fill_in_question('v_date_year',  '')
      fill_in_question('v_date_month', '')
      fill_in_question('v_date_day',   '')
      run_validations
      expect_error_on 'v_date', 'requires_answer'
    end

    scenario 'saving an invalid date' do
      fill_in_question('v_date_year',  '2013')
      fill_in_question('v_date_month', '12')
      fill_in_question('v_date_day',   '')
      run_validations
      expect_error_on 'v_date', 'regexp'
    end
  end

  context 'in_range validation' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_date, type: :date, year_key: :v_date_year, month_key: :v_date_month, day_key: :v_date_day do
          title "Enter a date"
          validates_in_range Date.new(2013, 1, 1)..Date.new(2013, 12, 31)
        end; end_panel
      END
    end

    scenario 'saving a valid date' do
      fill_in_question('v_date_year',  '2013')
      fill_in_question('v_date_month', '12')
      fill_in_question('v_date_day',   '10')
      run_validations
      expect_no_errors
      expect_saved_value 'v_date', '10-12-2013'
    end

    scenario 'saving an empty date' do
      fill_in_question('v_date_year',  '')
      fill_in_question('v_date_month', '')
      fill_in_question('v_date_day',   '')
      run_validations
      expect_no_errors
      expect_saved_value 'v_date', ''
    end

    scenario 'saving a too-low date' do
      fill_in_question('v_date_year',  '2011')
      fill_in_question('v_date_month', '4')
      fill_in_question('v_date_day',   '10')
      run_validations
      expect_error_on 'v_date', 'minimum'
    end

    scenario 'saving a too-high date' do
      fill_in_question('v_date_year',  '2015')
      fill_in_question('v_date_month', '3')
      fill_in_question('v_date_day',   '20')
      run_validations
      expect_error_on 'v_date', 'maximum'
    end

    scenario 'saving an invalid date' do
      fill_in_question('v_date_year',  'foo')
      fill_in_question('v_date_month', 'bar')
      fill_in_question('v_date_day',   'baz')
      run_validations
      expect_error_on 'v_date', 'regexp'

      fill_in_question('v_date_year',  '2013')
      fill_in_question('v_date_month', '10')
      fill_in_question('v_date_day',   '33')
      run_validations
      expect_error_on 'v_date', 'regexp'
    end
  end
end

feature 'Client-side validations on date questions', js: true do
  include ClientSideValidationHelpers
  it_behaves_like "validations on date questions"
end

feature 'Server-side validations on date questions' do
  include ServerSideValidationHelpers
  it_behaves_like 'validations on date questions'
end

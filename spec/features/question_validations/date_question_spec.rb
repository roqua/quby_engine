# frozen_string_literal: true

require 'spec_helper'

shared_examples 'validations on date questions' do
  before do
    allow_server_side_validation_error
  end
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
      fill_in_question('v_date_month', '02 ')
      fill_in_question('v_date_day',   '10')
      run_validations
      expect_no_errors
      expect_saved_value 'v_date', '10-02-2013'
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
      fill_in_question('v_date_month', '13')
      fill_in_question('v_date_day',   '')
      run_validations
      expect_error_on 'v_date', 'valid_date'
    end

    scenario 'saving a date with invalid characters' do
      fill_in_question('v_date_year',  '2013')
      fill_in_question('v_date_month', '13-03')
      fill_in_question('v_date_day',   '')
      run_validations
      expect_error_on 'v_date', 'valid_date'
    end

    scenario 'saving a date with invalid characters 2' do
      fill_in_question('v_date_year',  '2013')
      fill_in_question('v_date_month', '13')
      fill_in_question('v_date_day',   '03h')
      run_validations
      expect_error_on 'v_date', 'valid_date'
    end

    context 'when "components: [:year, :month]" is provided' do
      let(:questionnaire) do
        inject_questionnaire "test_with_components", <<-END
          question :v_date, type: :date, required: true,
                            year_key: :v_date_year, month_key: :v_date_month, day_key: :v_date_day,
                            components: [:year, :month] do
            title "Enter a date"
          end; end_panel
        END
      end

      scenario 'saving with valid year and month values' do
        fill_in_question('v_date_year',  '2013')
        fill_in_question('v_date_month', '12')
        run_validations
        expect_no_errors
      end

      scenario 'saving with only a year value' do
        fill_in_question('v_date_year',  '2013')
        run_validations
        expect_error_on 'v_date', 'valid_date'
      end
    end

    context 'when "components: [:hour, :minute]" is provided' do
      let(:questionnaire) do
        inject_questionnaire "test_with_components", <<-END
          question :v_date, type: :date, required: true,
                            hour_key: :v_date_hour, minute_key: :v_date_minute,
                            components: [:hour, :minute] do
            title "Enter a date"
          end; end_panel
        END
      end

      scenario 'saving with valid hour and minute values' do
        fill_in_question('v_date_hour',  '13')
        fill_in_question('v_date_minute', '59')
        run_validations
        expect_no_errors
      end

      scenario 'saving with zero values for hour and minute' do
        fill_in_question('v_date_hour',  '0')
        fill_in_question('v_date_minute', '0')
        run_validations
        expect_no_errors
      end

      scenario 'saving with invalid hour and minute values' do
        fill_in_question('v_date_hour',  '24')
        fill_in_question('v_date_minute', '60')
        run_validations
        expect_error_on 'v_date', 'valid_date'
      end
    end

    context 'when only the year is required' do
      let(:questionnaire) do
        inject_questionnaire "test_with_components", <<-END
          question :v_date, type: :date, required: true,
                            components: [:year, :month],
                            required_components: [:year] do
            title "Enter a date"
          end; end_panel
        END
      end

      scenario 'saving with valid month and year' do
        fill_in_question('v_date_yyyy', '2018')
        fill_in_question('v_date_mm', '10')
        run_validations
        expect_no_errors
        expect_saved_value 'v_date', '10-2018'
      end

      scenario 'saving with valid year only' do
        fill_in_question('v_date_yyyy', '2018')
        run_validations
        expect_no_errors
        expect_saved_value 'v_date', '2018'
      end

      scenario 'saving an empty date' do
        run_validations
        expect_error_on 'v_date', 'requires_answer'
      end

      scenario 'saving with missing year' do
        fill_in_question('v_date_mm', '10')
        run_validations
        expect_error_on 'v_date', 'valid_date'
      end
    end
  end

  context 'in_range validation' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_date, type: :date, year_key: :v_date_year, month_key: :v_date_month, day_key: :v_date_day do
          title "Enter a date"
          validates_in_range Date.new(2013, 1, 2)..Date.new(2013, 12, 31)
        end; end_panel
      END
    end

    scenario 'saving a valid date' do
      fill_in_question('v_date_year',  '2013')
      fill_in_question('v_date_month', '1')
      fill_in_question('v_date_day',   '2')
      run_validations
      expect_no_errors
      expect_saved_value 'v_date', '2-1-2013'
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
      expect_error_on 'v_date', 'valid_date'

      fill_in_question('v_date_year',  '2013')
      fill_in_question('v_date_month', '10')
      fill_in_question('v_date_day',   '33')
      run_validations
      expect_error_on 'v_date', 'valid_date'
    end
  end

  context 'when date is not required' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_date, type: :date, required: false,
                          year_key: :v_date_year, month_key: :v_date_month, day_key: :v_date_day do
          title "Enter a date"
        end; end_panel
      END
    end

    scenario 'saving a valid date' do
      fill_in_question('v_date_year',  '2013')
      fill_in_question('v_date_month', '02 ')
      fill_in_question('v_date_day',   '10')
      run_validations
      expect_no_errors
      expect_saved_value 'v_date', '10-02-2013'
    end

    scenario 'saving an invalid date' do
      fill_in_question('v_date_year',  '2013')
      fill_in_question('v_date_month', '10')
      fill_in_question('v_date_day',   '33')
      run_validations
      expect_error_on 'v_date', 'valid_date'
    end

    scenario 'saving an empty date' do
      fill_in_question('v_date_year',  '')
      fill_in_question('v_date_month', '')
      fill_in_question('v_date_day',   '')
      run_validations
      expect_no_errors
      expect_saved_value 'v_date', ''
    end
  end

  context 'when date is not required but there are required date components' do
    let(:questionnaire) do
      inject_questionnaire "test_with_components", <<-END
        question :v_date, type: :date, required: false,
                          components: [:year, :month],
                          required_components: [:year] do
          title "Enter a date"
        end; end_panel
      END
    end

    scenario 'saving an empty date' do
      fill_in_question('v_date_yyyy',  '')
      fill_in_question('v_date_mm', '')
      run_validations
      expect_no_errors
      expect_saved_value 'v_date', ''
    end

    scenario 'saving a valid date' do
      fill_in_question('v_date_yyyy',  '2013')
      fill_in_question('v_date_mm', '6')
      run_validations
      expect_no_errors
      expect_saved_value 'v_date', '6-2013'
    end

    scenario 'saving an invalid date' do
      fill_in_question('v_date_mm', '6')
      run_validations
      expect_error_on 'v_date', 'valid_date'
    end

    scenario 'saving a valid date with only required components' do
      fill_in_question('v_date_yyyy',  '2013')
      run_validations
      expect_no_errors
      expect_saved_value 'v_date', '2013'
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

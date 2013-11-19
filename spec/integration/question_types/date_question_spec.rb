require 'spec_helper'

feature 'Date questions' do
  let(:questionnaire) do
    inject_questionnaire "test", <<-END
      question :v_date, type: :date, required: true,
                        year_key: :v_date_year, month_key: :v_date_month, day_key: :v_date_day do
        title "Enter a date"
      end
    END
  end

  let(:answer) { Quby::Answer.create(questionnaire_key: questionnaire.key) }
  let(:updates_answers) { Quby::UpdatesAnswers.new(answer) }


  scenario 'saving a valid date' do
    updates_answers.update('v_date_year' => '2013', 'v_date_month' => '12', 'v_date_day' => '10')
    answer.v_date.should == '10-12-2013'
  end

  scenario 'saving without a date' do
    updates_answers.update('v_date_year' => '', 'v_date_month' => '', 'v_date_day' => '')
    answer.errors[:v_date].should be_present
  end

  scenario 'saving an invalid date' do
    updates_answers.update('v_date_year' => '2013', 'v_date_month' => '12', 'v_date_day' => '')
    answer.errors[:v_date].should be_present
  end
end
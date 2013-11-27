require 'spec_helper'

feature 'Date questions' do
  let(:answer) { Quby::Answer.create(questionnaire_key: questionnaire.key) }
  let(:updates_answers) { Quby::UpdatesAnswers.new(answer) }

  context 'requires_answer validation' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_date, type: :date, required: true,
                          year_key: :v_date_year, month_key: :v_date_month, day_key: :v_date_day do
          title "Enter a date"
        end
      END
    end

    scenario 'saving a valid date' do
      updates_answers.update('v_date_year' => '2013', 'v_date_month' => '12', 'v_date_day' => '10')
      answer.errors.should_not be_present
      answer.reload.v_date.should == '10-12-2013'
    end

    scenario 'saving without a date' do
      updates_answers.update('v_date_year' => '', 'v_date_month' => '', 'v_date_day' => '')
      answer.errors[:v_date].should eq([{message: 'Must be answered.', valtype: :requires_answer}])
    end

    scenario 'saving an invalid date' do
      updates_answers.update('v_date_year' => '2013', 'v_date_month' => '12', 'v_date_day' => '')
      answer.errors[:v_date].should eq([{message: 'Does not match pattern expected.', valtype: :regexp}])
    end
  end

  context 'in_range validation' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_date, type: :date, year_key: :v_date_year, month_key: :v_date_month, day_key: :v_date_day do
          title "Enter a date"
          validates_in_range Date.new(2013, 1, 1)..Date.new(2013, 12, 31)
        end
      END
    end

    scenario 'saving a valid date' do
      updates_answers.update('v_date_year' => '2013', 'v_date_month' => '12', 'v_date_day' => '10')
      answer.errors.should_not be_present
      answer.reload.v_date.should == '10-12-2013'
    end

    scenario 'saving a too-low date' do
      updates_answers.update('v_date_year' => '2011', 'v_date_month' => '4', 'v_date_day' => '10')
      answer.errors[:v_date].should eq([{message: 'Smaller than minimum', valtype: :minimum}])
    end

    scenario 'saving a too-high date' do
      updates_answers.update('v_date_year' => '2015', 'v_date_month' => '3', 'v_date_day' => '20')
      answer.errors[:v_date].should eq([{message: 'Exceeds maximum', valtype: :maximum}])
    end

    scenario 'saving an invalid date' do
      updates_answers.update('v_date_year' => 'foo', 'v_date_month' => 'bar', 'v_date_day' => 'baz')
      answer.errors[:v_date].should be_present

      answer.errors.clear
      updates_answers.update('v_date_year' => '2013', 'v_date_month' => '10', 'v_date_day' => '33')
      answer.errors[:v_date].should be_present

      answer.errors.clear
      updates_answers.update('v_date_year' => '', 'v_date_month' => '', 'v_date_day' => '')
      answer.errors[:v_date].should be_present
    end
  end
end
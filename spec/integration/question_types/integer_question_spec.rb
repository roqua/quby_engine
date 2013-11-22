require 'spec_helper'

feature 'Integer questions' do
  let(:questionnaire) do
    inject_questionnaire "test", <<-END
      question :v_integer, type: :integer, required: true do
        title "Enter a integer"
      end
    END
  end

  let(:answer) { Quby::Answer.create(questionnaire_key: questionnaire.key) }
  let(:updates_answers) { Quby::UpdatesAnswers.new(answer) }

  scenario 'saving a valid integer' do
    updates_answers.update('v_integer' => '1')
    answer.errors.should_not be_present
    answer.reload.v_integer.should == '1'
  end

  scenario 'saving a float' do
    updates_answers.update('v_integer' => '1.2')
    answer.errors[:v_integer].should be_present
  end

  scenario 'saving an invalid integer' do
    updates_answers.update('v_integer' => 'foo')
    answer.errors[:v_integer].should be_present
  end

  scenario 'saving without a integer' do
    updates_answers.update('v_integer' => '')
    answer.errors[:v_integer].should be_present
  end
end
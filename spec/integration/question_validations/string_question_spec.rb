require 'spec_helper'

feature 'String questions' do
  let(:questionnaire) do
    inject_questionnaire "test", <<-END
      question :v_string, type: :string, required: true do
        title "Enter a string"
      end
    END
  end

  let(:answer) { Quby::Answer.create(questionnaire_key: questionnaire.key) }
  let(:updates_answers) { Quby::UpdatesAnswers.new(answer) }

  scenario 'saving a valid string' do
    updates_answers.update('v_string' => 'kittens!')
    answer.errors.should_not be_present
    answer.reload.v_string.should == 'kittens!'
  end

  scenario 'saving without a string' do
    updates_answers.update('v_string' => '')
    answer.errors[:v_string].should be_present
  end
end
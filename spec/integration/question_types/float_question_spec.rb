require 'spec_helper'

feature 'Float questions' do
  let(:questionnaire) do
    inject_questionnaire "test", <<-END
      question :v_float, type: :float, required: true do
        title "Enter a float"
      end
    END
  end

  let(:answer) { Quby::Answer.create(questionnaire_key: questionnaire.key) }
  let(:updates_answers) { Quby::UpdatesAnswers.new(answer) }

  scenario 'saving a valid float' do
    updates_answers.update('v_float' => '1')
    answer.errors.should_not be_present
    answer.reload.v_float.should == '1'
  end

  scenario 'saving a float' do
    updates_answers.update('v_float' => '1.2')
    answer.errors.should_not be_present
    answer.reload.v_float.should == '1.2'
  end

  scenario 'saving an invalid float' do
    updates_answers.update('v_float' => 'foo')
    answer.errors[:v_float].should be_present
  end

  scenario 'saving without a float' do
    updates_answers.update('v_float' => '')
    answer.errors[:v_float].should be_present
  end
end
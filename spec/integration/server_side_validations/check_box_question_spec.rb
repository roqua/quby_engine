require 'spec_helper'

feature 'Checkbox questions' do
  let(:questionnaire) do
    inject_questionnaire "test", <<-END
      question :v_check_box, type: :check_box, required: true do
        title "Pick one"
        option :v_ck_a1, value: 1, description: 'Unicorns'
        option :v_ck_a2, value: 2, description: 'Rainbows'
      end
    END
  end

  let(:answer) { Quby::Answer.create(questionnaire_key: questionnaire.key) }
  let(:updates_answers) { Quby::UpdatesAnswers.new(answer) }

  scenario 'saving a valid choice' do
    updates_answers.update('v_ck_a1' => '1', 'v_ck_a2' => '1')
    answer.reload.v_check_box.should == {'v_ck_a1' => 1, 'v_ck_a2' => 1}
  end

  scenario 'saving without a choice' do
    updates_answers.update({})
    answer.errors[:v_check_box].should be_present
  end
end
require 'spec_helper'

feature 'Select questions' do
  let(:questionnaire) do
    inject_questionnaire "test", <<-END
      question :v_select, type: :select, required: true do
        title "Pick one"
        option :a1, value: 1, description: 'Unicorns'
        option :a2, value: 2, description: 'Rainbows'
      end
    END
  end

  let(:answer) { Quby::Answer.create(questionnaire_key: questionnaire.key) }
  let(:updates_answers) { Quby::UpdatesAnswers.new(answer) }

  scenario 'saving a valid choice' do
    updates_answers.update('v_select' => 'a01')
    answer.reload.v_select.should == 'a01'
  end

  scenario 'saving with an unknown select chosen' do
    # TODO: Is this the behaviour we really want?
    updates_answers.update('v_select' => 'aXX')
    answer.reload.v_select.should == 'aXX'
  end

  scenario 'saving without a choice' do
    updates_answers.update('v_select' => '')
    answer.errors[:v_select].should be_present
  end
end
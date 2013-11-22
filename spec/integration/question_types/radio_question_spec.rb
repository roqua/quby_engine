require 'spec_helper'

feature 'Radio questions' do
  let(:questionnaire) do
    inject_questionnaire "test", <<-END
      question :v_radio, type: :radio, required: true do
        title "Pick one"
        option :a1, value: 1, description: 'Unicorns'
        option :a2, value: 2, description: 'Rainbows'
      end
    END
  end

  let(:answer) { Quby::Answer.create(questionnaire_key: questionnaire.key) }
  let(:updates_answers) { Quby::UpdatesAnswers.new(answer) }

  scenario 'saving a valid choice' do
    updates_answers.update('v_radio' => 'a01')
    answer.reload.v_radio.should == 'a01'
  end

  scenario 'saving with an unknown radio chosen' do
    # TODO: Is this the behaviour we really want?
    updates_answers.update('v_radio' => 'aXX')
    answer.reload.v_radio.should == 'aXX'
  end

  scenario 'saving without a choice' do
    updates_answers.update('v_radio' => '')
    answer.errors[:v_radio].should be_present
  end
end
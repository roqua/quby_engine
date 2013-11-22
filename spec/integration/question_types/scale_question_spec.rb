require 'spec_helper'

feature 'Scale questions' do
  let(:questionnaire) do
    inject_questionnaire "test", <<-END
      question :v_scale, type: :scale, required: true do
        title "Pick one"
        option :a1, value: 1, description: 'Unicorns'
        option :a2, value: 2, description: 'Rainbows'
      end
    END
  end

  let(:answer) { Quby::Answer.create(questionnaire_key: questionnaire.key) }
  let(:updates_answers) { Quby::UpdatesAnswers.new(answer) }

  scenario 'saving a valid choice' do
    updates_answers.update('v_scale' => 'a01')
    answer.reload.v_scale.should == 'a01'
  end

  scenario 'saving with an unknown scale chosen' do
    # TODO: Is this the behaviour we really want?
    updates_answers.update('v_scale' => 'aXX')
    answer.reload.v_scale.should == 'aXX'
  end

  scenario 'saving without a choice' do
    updates_answers.update('v_scale' => '')
    answer.errors[:v_scale].should be_present
  end
end
require 'spec_helper'

feature 'Textarea questions' do
  let(:questionnaire) do
    inject_questionnaire "test", <<-END
      question :v_text_area, type: :text_area, required: true do
        title "Enter a text"
      end
    END
  end

  let(:answer) { Quby::Answer.create(questionnaire_key: questionnaire.key) }
  let(:updates_answers) { Quby::UpdatesAnswers.new(answer) }

  scenario 'saving a valid text_area' do
    updates_answers.update('v_text_area' => "kittens!\nthey are cute")
    answer.errors.should_not be_present
    answer.reload.v_text_area.should == "kittens!\nthey are cute"
  end

  scenario 'saving without a text_area' do
    updates_answers.update('v_text_area' => '')
    answer.errors[:v_text_area].should be_present
  end
end
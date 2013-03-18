require 'spec_helper'

feature 'Hiding questions' do
  let(:questionnaire) { Quby::Questionnaire.find_by_key("question_hiding") }

  scenario 'by clicking an option that hides a question', :js => true do
    visit_new_answer_for(questionnaire)
    choose "answer_v_6_a6"
    find("#answer_v_8_input").should_not be_visible
  end

  scenario 'by visiting an answer that has an option that hides something filled in', :js => true do
    answer = create_new_answer_for(questionnaire, "v_6" => "a6")
    visit_new_answer_for(questionnaire, "paged", answer)
    find("#answer_v_8_input").should_not be_visible
  end
end

feature 'Showing questions' do
  let(:questionnaire) { Quby::Questionnaire.find_by_key("question_hiding") }

  scenario 'by clicking an option that shows a question', :js => true do
    visit_new_answer_for(questionnaire)
    choose "answer_v_6_a6"
    choose "answer_v_7_a5"
    find("#answer_v_8_input").should be_visible
  end
  scenario 'by visiting an answer that has an option that shows something filled in', :js => true do
    answer = create_new_answer_for(questionnaire, "v_6" => "a6", "v_7" => "a6")
    visit_new_answer_for(questionnaire, "paged", answer)
    find("#answer_v_8_input").should be_visible
  end
end
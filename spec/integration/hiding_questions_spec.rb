require 'spec_helper'

feature 'Hiding questions' do
  let(:questionnaire) { Quby::Questionnaire.find_by_key("question_hiding") }

  scenario 'by clicking an option that hides a question', :js => true do
    visit_new_answer_for(questionnaire)
    choose "answer_v_6_a6"
    page.should have_selector("#item_v_8.hidden-childs")
  end

  scenario 'by visiting an answer that has an option that hides something filled in', :js => true do
    answer = create_new_answer_for(questionnaire, "v_6" => "a6")
    visit_new_answer_for(questionnaire, "paged", answer)
    page.should have_selector("#item_v_8.hidden-childs")
  end
end

feature 'Hiding all questions hides panels' do
  scenario 'in paged view' do

  end

  scenario 'in bulk view' do

  end

  scenario 'in print view' do

  end
end

feature 'Showing questions' do
  let(:questionnaire) { Quby::Questionnaire.find_by_key("question_hiding") }

  scenario 'by clicking an option that shows a question', :js => true do
    visit_new_answer_for(questionnaire)
    choose "answer_v_6_a6"
    choose "answer_v_7_a5"
    page.should_not have_selector("#item_v_8.hidden-childs")
  end
  scenario 'by visiting an answer that has an option that shows something filled in', :js => true do
    answer = create_new_answer_for(questionnaire, "v_6" => "a6", "v_7" => "a6")
    visit_new_answer_for(questionnaire, "paged", answer)
    page.should_not have_selector("#item_v_8.hidden-childs")
  end
end
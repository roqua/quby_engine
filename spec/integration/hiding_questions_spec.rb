require 'spec_helper'

feature 'Hiding questions' do
  let(:questionnaire) { Quby::Questionnaire.find_by_key("question_hiding") }

  scenario 'by clicking an option that hides a question', :js => true do
    visit_new_answer_for(questionnaire)
    choose "answer_v_6_a6"
    page.should have_selector("#item_v_8.hide")
  end

  scenario 'by visiting an answer that has an option that hides something filled in', :js => true do
    answer = create_new_answer_for(questionnaire, "v_6" => "a6")
    visit_new_answer_for(questionnaire, "paged", answer)
    page.should have_selector("#item_v_8.hide")
  end
end

feature 'Hiding all questions hides panels' do
  context 'in paged view' do
    let(:questionnaire) { Quby::Questionnaire.find_by_key("question_hiding") }
    scenario 'by clicking an option that hides all questions on a panel', :js => true do
      visit_new_answer_for(questionnaire)
      choose "answer_v_6_a6"
      page.should have_selector("#panel1.noVisibleQuestions")
    end
    scenario 'by visiting an answer that has an option that hides all questions on a panel filled in', :js => true do
      answer = create_new_answer_for(questionnaire, "v_6" => "a6")
      visit_new_answer_for(questionnaire, "paged", answer)
      page.should have_selector("#panel1.noVisibleQuestions")
    end
  end

  context 'in bulk view' do
    let(:questionnaire) { Quby::Questionnaire.find_by_key("question_hiding") }
    scenario 'by clicking an option that hides all questions on a panel', :js => true do
      visit_new_answer_for(questionnaire, "bulk")
      choose "answer_v_6_a6"
      page.should have_selector("#panel1.noVisibleQuestions")
    end
    scenario 'by visiting an answer that has an option that hides all questions on a panel filled in', :js => true do
      answer = create_new_answer_for(questionnaire, "v_6" => "a6")
      visit_new_answer_for(questionnaire, "bulk", answer)
      page.should have_selector("#panel1.noVisibleQuestions")
    end
  end
end

feature 'Showing questions' do
  let(:questionnaire) { Quby::Questionnaire.find_by_key("question_hiding") }
  scenario 'by clicking an option that shows a question', :js => true do
    visit_new_answer_for(questionnaire)
    choose "answer_v_6_a6"
    choose "answer_v_7_a5"
    page.should have_selector("#item_v_8.show")
  end
  scenario 'by visiting an answer that has an option that shows something filled in', :js => true do
    answer = create_new_answer_for(questionnaire, "v_6" => "a6", "v_7" => "a5")
    visit_new_answer_for(questionnaire, "paged", answer)
    page.should have_selector("#item_v_8.show")
  end
end

feature 'Default invisible questions' do
  let(:questionnaire) { Quby::Questionnaire.find_by_key("question_hiding") }
  scenario 'having :default_invisible => true set on a question start out invisible', :js => true do
    visit_new_answer_for(questionnaire)
    page.should have_selector("#item_v_9.hide")
  end
  scenario 'can be shown with show_questions', :js => true do
    visit_new_answer_for(questionnaire)
    choose "answer_v_7_a5"
    page.should have_selector("#item_v_9.show")
  end
end
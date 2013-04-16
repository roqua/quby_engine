require 'spec_helper'

feature 'Hiding questions' do
  let(:questionnaire) { Quby::Questionnaire.find_by_key("question_hiding") }

  scenario 'by clicking a radio option that hides a question', :js => true do
    visit_new_answer_for(questionnaire)
    choose "answer_v_6_a6"
    #to test whether it wont show the question after switching away from a second option that hides the question
    choose "answer_v_7_a6"
    choose "answer_v_7_a3"
    page.should have_selector("[data-for=v_8].hide", :count => 8)
  end

  scenario 'by clicking a checkbox option that hides a question', :js => true do
    visit_new_answer_for(questionnaire)
    check "answer_v_5_a2"
    #to test whether it wont show the question after checking another checkbox option
    check "answer_v_5_a3"
    page.should have_selector("#item_v_7.hide")
  end

  scenario 'by clicking a select option that hides a question', :js => true do
    visit_new_answer_for(questionnaire)
    select "hide 2", :from => "answer[v_4]"
    select "show 2, 4", :from => "answer[v_4]"
    select "hide 2", :from => "answer[v_4]"
    page.should have_selector("#item_v_7.hide")
  end

  scenario 'by visiting an answer that has an option that hides something filled in', :js => true do
    answer = create_new_answer_for(questionnaire, "v_6" => "a6")
    visit_new_answer_for(questionnaire, "paged", answer)
    page.should have_selector("[data-for=v_8].hide", :count => 8)
  end

  scenario 'unhiding by deselecting a question', :js => true do
    visit_new_answer_for(questionnaire)
    choose "answer_v_6_a6"
    choose "answer_v_6_a6"
    page.should have_selector("[data-for=v_8].show", :count => 8)
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

  scenario 'by clicking a radio option that shows a question', :js => true do
    visit_new_answer_for(questionnaire)
    choose "answer_v_6_a6"
    choose "answer_v_7_a5"
    page.should have_selector("[data-for=v_8].show", :count => 8)
  end

  scenario 'by clicking a checkbox option that shows a question', :js => true do
    visit_new_answer_for(questionnaire)
    check "answer_v_5_a1"
    check "answer_v_5_a2"
    page.should have_selector("#item_v_7.show")
  end

  scenario 'by clicking a select option that shows a question', :js => true do
    visit_new_answer_for(questionnaire)
    select "show 2, 4", :from => "answer[v_4]"
    select "hide 2", :from => "answer[v_4]"
    select "show 2, 4", :from => "answer[v_4]"
    page.should have_selector("[data-for=v_9].show", :count => 8)
  end

  scenario 'by visiting an answer that has an option that shows something filled in', :js => true do
    answer = create_new_answer_for(questionnaire, "v_6" => "a6", "v_7" => "a5")
    visit_new_answer_for(questionnaire, "paged", answer)
    page.should have_selector("[data-for=v_8].show", :count => 8)
  end
  scenario 'unshowing by deselecting a question', :js => true do
    visit_new_answer_for(questionnaire)
    choose "answer_v_6_a6"
    choose "answer_v_7_a5"
    choose "answer_v_7_a5"
    page.should have_selector("[data-for=v_8].hide", :count => 8)
  end
end

feature 'Default invisible questions' do
  let(:questionnaire) { Quby::Questionnaire.find_by_key("question_hiding") }
  scenario 'having :default_invisible => true set on a question start out invisible', :js => true do
    visit_new_answer_for(questionnaire)
    page.should have_selector("[data-for=v_9].hide", :count => 8)
  end
  scenario 'can be shown with show_questions', :js => true do
    visit_new_answer_for(questionnaire)
    choose "answer_v_7_a5"
    page.should have_selector("[data-for=v_9].show", :count => 8)
  end
end
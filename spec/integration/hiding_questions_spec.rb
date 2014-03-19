require 'spec_helper'

feature 'Hiding questions' do
  let(:questionnaire) { Quby.questionnaire_finder.find("question_hiding") }

  scenario 'by clicking a radio option that hides a question', js: true do
    visit_new_answer_for(questionnaire)
    choose "answer_v_6_a6"
    # to test whether it wont show the question after switching away from a second option that hides the question
    choose "answer_v_7_a6"
    choose "answer_v_7_a3"
    page.should have_selector("[data-for=v_8].hide", count: 8, visible: false)
    page.should have_selector("[data-for=v_10].hide, #answer_v_10_input.hide", count: 2, visible: false)
    page.should have_selector("[data-for=v_11].hide, #answer_v_11_input.hide", count: 2, visible: false)
    page.should have_selector("[data-for=v_12].hide, #answer_v_12_input.hide", count: 2, visible: false)
    page.should have_selector("[data-for=v_13].hide, #answer_v_13_input.hide", count: 2, visible: false)
  end

  scenario 'by clicking a checkbox option that hides a question', js: true do
    visit_new_answer_for(questionnaire)
    check "answer_v_5_a2"
    # to test whether it wont show the question after checking another checkbox option
    check "answer_v_5_a3"
    page.should have_selector("#item_v_7.hide")
  end

  scenario 'by clicking a select option that hides a question', js: true do
    visit_new_answer_for(questionnaire)
    select "hide 2", from: "answer[v_4]"
    select "show 2,4,5,6,7,8", from: "answer[v_4]"
    select "hide 2", from: "answer[v_4]"
    page.should have_selector("#item_v_7.hide")
  end

  scenario 'by visiting an answer that has an option that hides something filled in', js: true do
    answer = create_new_answer_for(questionnaire, "v_6" => "a6")
    visit_new_answer_for(questionnaire, "paged", answer)
    page.should have_selector("[data-for=v_8].hide", count: 8, visible: false)
  end

  scenario 'unhiding by deselecting a question', js: true do
    visit_new_answer_for(questionnaire)
    choose "answer_v_6_a6"
    choose "answer_v_6_a6"
    page.should have_selector("[data-for=v_8].show", count: 8, visible: false)
  end

  scenario 'does not hide in bulk version due to different css', js: true do
    visit_new_answer_for(questionnaire, "bulk")
    choose "answer_v_6_a6"
    page.should have_selector("[data-for=v_8].hide", count: 8, visible: true)
  end
end

feature 'Hiding all questions hides panels' do
  context 'in paged view' do
    let(:questionnaire) { Quby.questionnaire_finder.find("question_hiding") }

    scenario 'by clicking an option that hides all questions on a panel', js: true do
      visit_new_answer_for(questionnaire)
      choose "answer_v_6_a6"
      page.should have_selector("#panel1.noVisibleQuestions", visible: false)
    end

    scenario 'by visiting an answer that has an option that hides all questions on a panel filled in', js: true do
      answer = create_new_answer_for(questionnaire, "v_6" => "a6")
      visit_new_answer_for(questionnaire, "paged", answer)
      page.should have_selector("#panel1.noVisibleQuestions", visible: false)
    end
  end

  context 'in bulk view' do
    let(:questionnaire) { Quby.questionnaire_finder.find("question_hiding") }
    scenario 'clicking an option that hides all questions on a panel does not hide', js: true do
      visit_new_answer_for(questionnaire, "bulk")
      choose "answer_v_6_a6"
      page.should have_selector("#panel1.noVisibleQuestions", visible: true)
    end
    scenario 'visiting an answer that has an option that hides all questions on a panel filled in does not hide',
             js: true do
      answer = create_new_answer_for(questionnaire, "v_6" => "a6")
      visit_new_answer_for(questionnaire, "bulk", answer)
      page.should have_selector("#panel1.noVisibleQuestions", visible: true)
    end
  end
end

feature 'Showing questions' do
  let(:questionnaire) { Quby.questionnaire_finder.find("question_hiding") }

  scenario 'by clicking a radio option that shows a question', js: true do
    visit_new_answer_for(questionnaire)
    choose "answer_v_6_a6"
    choose "answer_v_7_a5"
    page.should have_selector("[data-for=v_8].show", count: 8, visible: false)
    page.should have_selector("[data-for=v_10].show, #answer_v_10_input.show", count: 2, visible: false)
    page.should have_selector("[data-for=v_11].show, #answer_v_11_input.show", count: 2, visible: false)
    page.should have_selector("[data-for=v_12].show, #answer_v_12_input.show", count: 2, visible: false)
    page.should have_selector("[data-for=v_13].show, #answer_v_13_input.show", count: 2, visible: false)
  end

  scenario 'by clicking a checkbox option that shows a question', js: true do
    visit_new_answer_for(questionnaire)
    check "answer_v_5_a1"
    check "answer_v_5_a2"
    page.should have_selector("#item_v_7.show")
  end

  scenario 'by clicking a select option that shows a question', js: true do
    visit_new_answer_for(questionnaire)
    select "show 2,4,5,6,7,8", from: "answer[v_4]"
    select "hide 2", from: "answer[v_4]"
    select "show 2,4,5,6,7,8", from: "answer[v_4]"
    page.should have_selector("[data-for=v_9].show", count: 8, visible: false)
  end

  scenario 'by visiting an answer that has an option that shows something filled in', js: true do
    answer = create_new_answer_for(questionnaire, "v_6" => "a6", "v_7" => "a5")
    visit_new_answer_for(questionnaire, "paged", answer)
    page.should have_selector("[data-for=v_8].show", count: 8, visible: false)
  end

  scenario 'unshowing by deselecting a question', js: true do
    visit_new_answer_for(questionnaire)
    choose "answer_v_6_a6"
    choose "answer_v_7_a5"
    choose "answer_v_7_a5"
    page.should have_selector("[data-for=v_8].hide", count: 8, visible: false)
  end
end

feature 'Default invisible questions' do
  let(:questionnaire) { Quby.questionnaire_finder.find("question_hiding") }
  scenario 'having default_invisible: true set on a question start out invisible', js: true do
    visit_new_answer_for(questionnaire)
    page.should have_selector("[data-for=v_9].hide", count: 8, visible: false)
  end

  scenario 'can be shown with shows_questions', js: true do
    visit_new_answer_for(questionnaire)
    choose "answer_v_7_a5"
    page.should have_selector("[data-for=v_9].show", count: 8, visible: false)
  end

  scenario 'are visible in bulk view', js: true do
    visit_new_answer_for(questionnaire, "bulk")
    page.should have_selector("[data-for=v_9].hide", count: 8, visible: true)
  end
end

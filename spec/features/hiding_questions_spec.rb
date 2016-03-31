require 'spec_helper'

feature 'Hiding and showing questions' do
  let(:questionnaire) { Quby.questionnaires.find("question_hiding") }

  context 'Hiding questions' do
    scenario 'by clicking a radio option that hides a question', js: true do
      answer = visit_new_answer_for(questionnaire)

      goto_second_page
      choose "answer_v_8_a2" # Give an answer for the question that will be hidden

      goto_first_page
      choose "answer_v_6_a6" # Hides the v_8 question
      choose "answer_v_7_a6" # Shows the v_8 question
      choose "answer_v_7_a3" # Deselect the showing condition and question should be hidden again
      expect(page).to have_selector("[data-for=v_8].hide", count: 8, visible: false)
      expect(page).to have_selector("[data-for=v_10].hide, #answer_v_10_input.hide", count: 2, visible: false)
      expect(page).to have_selector("[data-for=v_11].hide, #answer_v_11_input.hide", count: 2, visible: false)
      expect(page).to have_selector("[data-for=v_12].hide, #answer_v_12_input.hide", count: 2, visible: false)
      expect(page).to have_selector("[data-for=v_13].hide, #answer_v_13_input.hide", count: 2, visible: false)

      goto_third_page and save_form
      expect(Quby.answers.reload(answer).value).to eq(answer_value("v_6" => "a6", "v_7" => "a3",
                                              "v_10_dd" => nil, "v_10_mm" => nil, "v_10_yyyy" => nil))
    end

    scenario 'by clicking a checkbox option that hides a question', js: true do
      answer = visit_new_answer_for(questionnaire)
      choose "answer_v_7_a2" # Give an answer for the question that will be hidden
      check "answer_v_5_a2"  # Hides the v_7 question
      check "answer_v_5_a3"  # Test whether it wont show the question after checking another checkbox option
      expect(page).to have_selector("#item_v_7.hide")

      # Test that data gets saved
      goto_second_page
      goto_third_page and save_form
      expect(Quby.answers.reload(answer).value)
        .to eq(answer_value("v_5" => {"v_5_a1" => 0, "v_5_a2" => 1, "v_5_a3" => 1},
                                "v_5_a1" => 0, "v_5_a2" => 1, "v_5_a3" => 1))
    end

    scenario 'by clicking a select option that hides a question', js: true do
      answer = visit_new_answer_for(questionnaire)
      choose "answer_v_7_a2"
      select "hide 2", from: "answer[v_4]"
      select "show 2,4,5,6,7,8", from: "answer[v_4]"
      select "hide 2", from: "answer[v_4]"
      expect(page).to have_selector("#item_v_7.hide")

      goto_second_page
      goto_third_page and save_form
      expect(Quby.answers.reload(answer).value).to eq(answer_value("v_4" => "a2"))
    end

    scenario 'by visiting an answer that has an option that hides something filled in', js: true do
      answer = create_new_answer_for(questionnaire, "v_6" => "a6")
      visit_new_answer_for(questionnaire, "paged", answer)
      expect(page).to have_selector("[data-for=v_8].hide", count: 8, visible: false)

      goto_third_page and save_form
      expect(Quby.answers.reload(answer).value).to eq(answer_value("v_6" => "a6", "v_10_dd" => nil,
                                                               "v_10_mm" => nil, "v_10_yyyy" => nil))
    end

    scenario 'by visiting an answer with a flag that hides a question set to true', js: true do
      answer = create_new_answer_for(questionnaire, {}, flags: {question_hiding_hides_flag: true})
      visit_new_answer_for(questionnaire, "paged", answer)
      expect(page).to have_selector("#item_v_7.hide", visible: false)
    end

    scenario 'editing an answer to hide a question should remove the value', js: true do
      answer = visit_new_answer_for(questionnaire)

      # if i have a question that is not hidden, and i give a value
      # for that question and save the form, that value is saved.
      select "licht", from: "answer[v_4]"
      choose "answer_v_7_a1"
      goto_second_page and goto_third_page and save_form
      expect(Quby.answers.reload(answer).value).to eq(answer_value("v_4" => "a3", "v_7" => "a1"))

      # if i then edit the answer such that the question is now hidden, it should
      # should be correctly wiped upon saving the answer
      visit_new_answer_for(questionnaire, "paged", answer)
      select "hide 2", from: "answer[v_4]"
      goto_second_page and goto_third_page and save_form
      expect(Quby.answers.reload(answer).value).to eq(answer_value("v_4" => "a2"))
    end

    scenario 'unhiding by deselecting a question', js: true do
      answer = visit_new_answer_for(questionnaire)
      choose "answer_v_6_a6"
      choose "answer_v_6_a6"
      expect(page).to have_selector("[data-for=v_8].show", count: 8, visible: false)

      goto_second_page and goto_third_page and save_form
      expect(Quby.answers.reload(answer).value).to eq(answer_value)
    end

    scenario 'does not hide in bulk version due to different css', js: true do
      answer = visit_new_answer_for(questionnaire, "bulk")
      choose "answer_v_6_a6"
      expect(page).to have_selector("[data-for=v_8].hide", count: 8, visible: true)

      pending "Actual saving of values is BROKEN"
      choose "answer_v_8_a2"
      save_form
      expect(Quby.answers.reload(answer).value).to eq(answer_value("v_6" => "a6", "v_8" => "a2"))
    end

    scenario 'by unchecking a check box question through the uncheck_all_option', js: true do
      visit_new_answer_for(questionnaire)

      check "answer_v_14_a1"
      check "answer_v_14_a3"

      goto_second_page

      # Test that question 9 got hidden
      expect(page).to have_selector("[data-for=v_9].hide", count: 8, visible: false)
    end

    scenario 'by checking a check box question through the check_all_option', js: true do
      visit_new_answer_for(questionnaire)

      check "answer_v_15_a3"

      goto_second_page

      # Test that question 8 got hidden
      expect(page).to have_selector("[data-for=v_8].hide", count: 8, visible: false)
    end
  end

  context 'Hiding all questions hides panels' do
    context 'in paged view' do
      scenario 'by clicking an option that hides all questions on a panel', js: true do
        visit_new_answer_for(questionnaire)
        choose "answer_v_6_a6"
        expect(page).to have_selector("#panel1.noVisibleQuestions", visible: false)
      end

      scenario 'by visiting an answer that has an option that hides all questions on a panel filled in', js: true do
        answer = create_new_answer_for(questionnaire, "v_6" => "a6")
        visit_new_answer_for(questionnaire, "paged", answer)
        expect(page).to have_selector("#panel1.noVisibleQuestions", visible: false)
      end
    end

    context 'in bulk view' do
      scenario 'clicking an option that hides all questions on a panel does not hide', js: true do
        visit_new_answer_for(questionnaire, "bulk")
        choose "answer_v_6_a6"
        expect(page).to have_selector("#panel1.noVisibleQuestions", visible: true)
      end

      scenario 'visiting an answer that has an option that hides all questions on a panel filled in does not hide',
               js: true do
        answer = create_new_answer_for(questionnaire, "v_6" => "a6")
        visit_new_answer_for(questionnaire, "bulk", answer)
        expect(page).to have_selector("#panel1.noVisibleQuestions", visible: true)
      end
    end
  end

  context 'Showing questions' do
    scenario 'by clicking a radio option that shows a question', js: true do
      answer = visit_new_answer_for(questionnaire)
      choose "answer_v_6_a6" # Trigger a hiding condition for v_8
      choose "answer_v_7_a5" # Trigger an overriding show condition for v_8

      # Test that fields get shown
      expect(page).to have_selector("[data-for=v_8].show", count: 8, visible: false)
      expect(page).to have_selector("[data-for=v_10].show, #answer_v_10_input.show", count: 2, visible: false)
      expect(page).to have_selector("[data-for=v_11].show, #answer_v_11_input.show", count: 2, visible: false)
      expect(page).to have_selector("[data-for=v_12].show, #answer_v_12_input.show", count: 2, visible: false)
      expect(page).to have_selector("[data-for=v_13].show, #answer_v_13_input.show", count: 2, visible: false)

      # Test that data can be saved
      fill_in 'answer_v_10_dd',   with: '10'
      fill_in 'answer_v_10_mm',   with: '02'
      fill_in 'answer_v_10_yyyy', with: '1999'
      fill_in 'answer_v_11',      with: 'some string'
      fill_in 'answer_v_12',      with: '123'
      fill_in 'answer_v_13',      with: 'some textarea content'

      goto_second_page
      choose "answer_v_8_a1"
      choose "answer_v_9_a1"

      goto_third_page and save_form
      expect(Quby.answers.reload(answer).value)
        .to eq(answer_value("v_6" => "a6",
                                "v_7" => "a5",
                                "v_10_dd" => "10",
                                "v_10_mm" => "02",
                                "v_10_yyyy" => "1999",
                                "v_11" => "some string",
                                "v_12" => "123",
                                "v_13" => "some textarea content",
                                "v_8" => "a1",
                                "v_9" => "a1"))
    end

    scenario 'by clicking a checkbox option that shows a question', js: true do
      answer = visit_new_answer_for(questionnaire)
      check "answer_v_5_a1"
      check "answer_v_5_a2"

      # Test that fields get shown
      expect(page).to have_selector("#item_v_7.show")

      # Test that data can be saved
      choose "answer_v_7_a1" # answer a question that would be hidden by v_5_a1 were it not for a2
      goto_second_page
      choose "answer_v_9_a1" # answer a question that would be default_invisible were it not for a2

      goto_third_page and save_form
      expect(Quby.answers.reload(answer).value)
        .to eq(answer_value("v_5" => {"v_5_a1" => 1, "v_5_a2" => 1, "v_5_a3" => 0},
                                "v_5_a1" => 1, "v_5_a2" => 1, "v_7" => "a1", "v_9" => "a1"))
    end

    scenario 'by clicking a select option that shows a question', js: true do
      answer = visit_new_answer_for(questionnaire)
      select "show 2,4,5,6,7,8", from: "answer[v_4]"
      select "hide 2", from: "answer[v_4]"
      select "show 2,4,5,6,7,8", from: "answer[v_4]"

      # Test that fields get shown
      expect(page).to have_selector("[data-for=v_9].show", count: 8, visible: false)

      # Test that data can be saved
      goto_second_page
      choose "answer_v_9_a1"
      goto_third_page and save_form
      expect(Quby.answers.reload(answer).value)
        .to eq(answer_value("v_4" => "a1", "v_9" => "a1"))
    end

    scenario 'by visiting an answer that has a radio option that shows something filled in', js: true do
      answer = create_new_answer_for(questionnaire, "v_6" => "a6", "v_7" => "a5")
      visit_new_answer_for(questionnaire, "paged", answer)
      goto_second_page
      expect(page).to have_selector("[data-for=v_8].show", count: 8)
      choose "answer_v_8_a3"
      goto_third_page and save_form
      expect(Quby.answers.reload(answer).value)
        .to eq(answer_value("v_6" => "a6", "v_7" => "a5", "v_8" => "a3"))
    end

    scenario 'by visiting an answer with a flag that shows a question set to true', js: true do
      answer = create_new_answer_for(questionnaire, {}, flags: {question_hiding_shows_flag: true})
      visit_new_answer_for(questionnaire, "paged", answer)
      goto_second_page
      expect(page).to have_selector("[data-for=v_9].show", count: 8)
      choose "answer_v_9_a2"
      goto_third_page and save_form
      expect(page).to have_content("Uw antwoorden zijn opgeslagen")
      expect(Quby.answers.reload(answer).value)
        .to eq(answer_value("v_9" => "a2"))
    end

    scenario 'by visiting an answer that has a checkbox option that shows something filled in', js: true do
      answer = create_new_answer_for(questionnaire, "v_5" => { "v_5_a1" => 1, "v_5_a2" => 1, "v_5_a3" => 0 },
                                                    "v_5_a1" => 1, "v_5_a2" => 1)
      visit_new_answer_for(questionnaire, "paged", answer)
      expect(page).to have_selector("#item_v_7.show")
      goto_second_page
      expect(page).to have_selector("[data-for=v_9].show")
      goto_third_page and save_form
      expect(Quby.answers.reload(answer).value)
        .to eq(answer_value("v_5" => { "v_5_a1" => 1, "v_5_a2" => 1, "v_5_a3" => 0 },
                                                      "v_5_a1" => 1, "v_5_a2" => 1))
    end

    scenario 'unshowing by deselecting a question', js: true do
      answer = visit_new_answer_for(questionnaire)

      # Choose something from question that will be hidden
      goto_second_page
      choose "answer_v_8_a1"

      goto_first_page
      choose "answer_v_6_a6" # Hides v_8
      choose "answer_v_7_a5" # Select option that shows v_8
      choose "answer_v_7_a5" # Deselect option that shows v_8

      # Test that question got hidden
      expect(page).to have_selector("[data-for=v_8].hide", count: 8, visible: false)

      # Test that data from hidden v_8 does not get saved
      goto_third_page and save_form
      expect(Quby.answers.reload(answer).value)
        .to eq(answer_value("v_6" => "a6", "v_10_dd" => nil,
                                           "v_10_mm" => nil, "v_10_yyyy" => nil))
    end

    scenario 'by unchecking a check box question through the uncheck_all_option', js: true do
      visit_new_answer_for(questionnaire)

      check "answer_v_14_a2"
      check "answer_v_14_a3"

      goto_second_page

      # Test that question 8 got shown
      expect(page).to have_selector("[data-for=v_8].show", count: 8)
    end

    scenario 'by checking a check box question through the check_all_option', js: true do
      visit_new_answer_for(questionnaire)

      check "answer_v_15_a3"

      goto_second_page

      # Test that question 9 got shown
      expect(page).to have_selector("[data-for=v_9].show", count: 8)
    end
  end

  context 'Default invisible questions' do
    scenario 'having default_invisible: true set on a question start out invisible', js: true do
      visit_new_answer_for(questionnaire)
      expect(page).to have_selector("[data-for=v_9].hide", count: 8, visible: false)
    end

    scenario 'can be shown with shows_questions', js: true do
      answer = visit_new_answer_for(questionnaire)
      choose "answer_v_7_a5"
      goto_second_page
      expect(page).to have_selector("[data-for=v_9].show", count: 8)

      # Test that data can be saved
      choose "answer_v_9_a2"
      goto_third_page and save_form
      expect(Quby.answers.reload(answer).value).to eq(answer_value("v_7" => "a5", "v_9" => "a2"))
    end

    scenario 'are visible in bulk view', js: true do
      answer = visit_new_answer_for(questionnaire, "bulk")
      expect(page).to have_selector("[data-for=v_9].hide", count: 8, visible: true)

      pending "Actual saving of values is BROKEN"
      choose "answer_v_9_a2"
      save_form
      expect(page).to have_content("Uw antwoorden zijn opgeslagen")
      expect(Quby.answers.reload(answer).value).to eq(answer_value("v_9" => "a2"))
    end
  end

  def goto_first_page
    click_on "Terug"
    expect(page).to have_content "P00"
  end

  def goto_second_page
    click_on "Verder"
    expect(page).to have_content "Text"
  end

  def goto_third_page
    click_on "Verder"
    expect(page).to have_content "Sla de antwoorden op door"
  end

  def save_form
    click_on "Klaar"
    expect(page).to have_content("Uw antwoorden zijn opgeslagen")
  end

  def answer_value(override = {})
    {
      "v_4" => nil,
      "v_5" => { "v_5_a1" => 0, "v_5_a2" => 0, "v_5_a3" => 0 },
      "v_5_a1" => 0, "v_5_a2" => 0, "v_5_a3" => 0,
      "v_6" => nil,
      "v_7" => nil, "v_7sub" => nil,
      "v_8" => nil,
      "v_9" => nil,
      "v_10_dd" => "", "v_10_mm" => "", "v_10_yyyy" => "",
      "v_11" => nil,
      "v_12" => nil,
      "v_13" => nil,
      "v_14" => { "v_14_a1" => 0, "v_14_a2" => 0, "v_14_a3" => 0 },
      "v_14_a1" => 0,
      "v_14_a2" => 0,
      "v_14_a3" => 0,
      "v_15" => { "v_15_a1" => 0, "v_15_a2" => 0, "v_15_a3" => 0 },
      "v_15_a1" => 0,
      "v_15_a2" => 0,
      "v_15_a3" => 0
    }.merge(override)
  end
end

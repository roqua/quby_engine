require 'spec_helper'

feature 'Completing a questionnaire' do
  let(:questionnaire) { Quby.questionnaires.find("subset_mansa") }

  scenario 'by filling out pages', js: true do
    visit_new_answer_for(questionnaire)
    find("#panel0").should be_visible

    click_on "nextButton0"
    find("#panel1").should be_visible

    within("#item_v_1") { choose "gemengd" }
    within("#item_v_6") { choose "zeer ontevreden" }
    within("#item_v_7") { choose "zeer tevreden" }

    click_on "nextButton1"
    find("#panel2").should be_visible

    click_on "prevButton2"
    find("#panel1").should be_visible
    find("#panel2", visible: false).should_not be_visible

    click_on "nextButton1"
    find("#panel2").should be_visible

    within("#item_v_8") { choose "gemengd" }
    within("#item_v_9") { choose "zeer ontevreden" }
    within("#item_v_10") { choose "zeer tevreden" }

    click_on "nextButton2"
    find("#panel3").should be_visible

    within("#item_v_11") { choose "Ja" }
    within("#item_v_12") { choose "zeer ontevreden" }
    within("#item_v_13") { choose "Nee" }

    click_on "nextButton3"
    find("#panel4").should be_visible

    click_on "Klaar"
    page.should have_content("Uw antwoorden zijn opgeslagen")
  end

  scenario 'when a return address has been specified', js: true do
    questionnaire = inject_questionnaire("test", <<-END)
      question :v1, type: :float; end_panel
    END

    visit_new_answer_for(questionnaire, 'paged', nil, return_url: '/after_answer_complete')
    page.should have_selector('#panel0.current')
    click_on "nextButton0"

    page.should have_selector('#panel1.current')
    click_on "Klaar"

    page.should have_content 'answer_complete!'
    page.current_path.should eq '/after_answer_complete'
  end

  scenario 'when the first questionnaire submit gives a serverside validation error', js: true do
    questionnaire = inject_questionnaire("test", <<-END)
      question :v1, type: :float, required: true; end_panel
    END

    visit_new_answer_for(questionnaire)

    # make sure the faulty answer reaches the server.
    page.driver.execute_script "window.skipValidations = true;"

    page.should have_selector('#panel0.current')
    click_on "nextButton0"
    page.should have_selector('#panel1.current')
    click_on "Klaar"

    # the validation error is displayed on the page
    page.should have_selector('.error.requires_answer')

    page.driver.execute_script "window.skipValidations = false;"

    fill_in 'answer[v1]', with: '1'

    click_on "nextButton0"
    page.should have_selector('#panel1.current')
    click_on "Klaar"

    # and a second attempt can be made
    page.should have_content("Uw antwoorden zijn opgeslagen")
  end

  # scenario 'when the first questionnaire submit fails', js: true do
  #   questionnaire = inject_questionnaire("test", <<-END)
  #     question :v1, type: :float; end_panel
  #   END

  #   visit_new_answer_for(questionnaire)
  #   page.should have_selector('#panel0.current')
  #   fill_in 'answer[v1]', with: '1'
  #   click_on "nextButton0"
  #   page.should have_selector('#panel1.current')
  #   original_action = page.evaluate_script('$("form.test").attr("action")')
  #   page.execute_script('$("form.test").attr("action", "http://inexistant.domain")')
  #   click_on "Klaar"

  #   # an error message is displayed on the page
  #   page.should have_content('Er ging iets fout bij het opslaan van de antwoorden')

  #   # and a second attempt can be made to save the data
  #   page.execute_script("$('form.test').attr('action', '#{original_action}')")
  #   click_on "Klaar"
  #   page.should have_content("Uw antwoorden zijn opgeslagen")
  # end

  scenario 'by filling out a bulk version', js: true do
    visit_new_answer_for(questionnaire, "bulk")

    within("#item_v_1") { choose "answer_v_1_a3" }
    within("#item_v_6") { choose "answer_v_6_a5" }
    within("#item_v_7") { choose "answer_v_7_a2" }
    within("#item_v_8") { choose "answer_v_8_a3" }
    within("#item_v_9") { choose "answer_v_9_a3" }
    within("#item_v_10") { choose "answer_v_10_a1" }
    within("#item_v_11") { choose "answer_v_11_a1" }
    within("#item_v_12") { choose "answer_v_12_a4" }
    within("#item_v_13") { choose "answer_v_13_a1" }

    click_on "Klaar"
    page.should have_content("Uw antwoorden zijn opgeslagen")
  end

  scenario 'by not filling in answers, but asking to save regardless', js: true do
    visit_new_answer_for(questionnaire, "bulk")

    click_on "Klaar"
    click_on "Toch opslaan"
    page.should have_content("Uw antwoorden zijn opgeslagen")
  end
end

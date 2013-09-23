require 'spec_helper'

feature 'Completing a questionnaire' do
  let(:mansa) { Quby::Questionnaire.find_by_key("mansa") }
  scenario 'by filling out pages', js: true do
    visit_new_answer_for(mansa)
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
    page.should have_content("Bedankt voor het invullen")
  end

  scenario 'by filling out a bulk version', js: true do
    visit_new_answer_for(mansa, "bulk")

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
    page.should have_content("Bedankt voor het invullen")
  end

  scenario 'by not filling in answers, but asking to save regardless', js: true do
    visit_new_answer_for(mansa, "bulk")

    click_on "Klaar"
    click_on "Toch opslaan"
    page.should have_content("Bedankt voor het invullen")
  end
end
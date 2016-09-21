require 'spec_helper'

module Quby
  describe "quby/answers/single_page/panel" do
    let(:questionnaire) { inject_questionnaire("test", <<-END) }
      panel do
        question :v1, type: :radio, required: true do
          title "Verbergt vraag 2"
          option :a1, value: 1, description: "Ja", hides_questions: [:v2]
          option :a2, value: 2, description: "Nee"
        end

        question :v2, type: :string, required: true do
          title "Vul dit in"
        end

        question :v3, type: :radio, required: true do
          title "Verbergt vraag 4 op volgende panel"
          option :a1, value: 1, description: "Ja", hides_questions: [:v4]
          option :a2, value: 2, description: "Nee"
        end
      end

      panel do
        question :v4, type: :string do
          title "Vraag 4"
        end

        question :v5, type: :check_box, required: true do
          title "Verbergt vraag 6"
          option :a1, value: 1, description: "Ja" do
            question :v6, type: :string, required: true do
              title 'Vul dit ook in'
            end
          end
        end
      end
    END

    it 'shows all panels and questions' do
      visit_new_answer_for(questionnaire, "single_page")

      page.should have_selector('.panel', count: 2)
      page.should have_content('Verbergt vraag 2')
      page.should have_content('Vul dit in')
      page.should have_content('Verbergt vraag 4 op volgende panel')
      page.should have_content('Vraag 4')
      page.should have_content('Verbergt vraag 6')
      page.should have_content('Vul dit ook in')
    end

    it 'does not hide questions in same panel' do
      visit_new_answer_for(questionnaire, "single_page")

      within("#item_v1") { choose "Ja" }
      find("#item_v2").find('.main').should be_visible
    end

    it 'does not hide questions in other panel' do
      visit_new_answer_for(questionnaire, "single_page")

      within("#item_v3") { choose "Ja" }
      find("#item_v4").find('.main').should be_visible
    end

    it 'does enable/disable subquestions', js: true do
      visit_new_answer_for(questionnaire, "single_page")

      # Subquestion disabled by default
      page.should have_css('#item_v6 #answer_v6[disabled=disabled]')

      # Checking parent should enable subquestion
      within("#item_v5") { check "Ja" }
      page.should have_no_css('#item_v6 #answer_v6[disabled=disabled]')

      # Unchecking parent should disable subquestion
      within("#item_v5") { uncheck "Ja" }
      page.should have_css('#item_v6 #answer_v6[disabled=disabled]')
    end

    it 'can skip validation' do
      visit_new_answer_for(questionnaire, "single_page")

      # Show warning first
      click_on('Klaar')
      page.should have_content("De vragenlijst is nog niet volledig ingevuld.")

      # But allow to skip validation and save
      click_on('Toch opslaan')
      page.should have_content("Uw antwoorden zijn opgeslagen")
    end
  end
end

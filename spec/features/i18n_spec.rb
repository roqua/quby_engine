require 'spec_helper'

feature 'Validation messages' do
  let(:questionnaire_without_language_setting) { Quby::Questionnaires::Entities::Questionnaire.new("simple") }
  let(:english_questionnaire) { Quby::Questionnaires::Entities::Questionnaire.new("english") }

  describe 'Setting interface language based on questionnaire setting' do
    scenario 'when no language is specified it defaults to dutch' do
      visit_new_answer_for(questionnaire_without_language_setting)

      expect_done_button_text 'Klaar'
    end

    scenario 'when "language: :en" is specified it renders the page in English' do
      visit_new_answer_for(english_questionnaire)

      expect_done_button_text 'Done'
    end

    def expect_done_button_text(text)
      expect(page).to have_selector("input#done-button[value='#{text}']")
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

module Quby
  describe "quby/answers/paged/panel" do
    let(:questionnaire) { inject_questionnaire("panels", <<-END) }
      title "Questionnaire with a bunch of panels"

      panel do
        text "First panel"
      end

      panel do
        text "Second panel"
      end

      panel do
        text "Third panel"
      end
    END

    it 'renders progress bar for paged questionnaires with more than one panel' do
      visit_new_answer_for(questionnaire)
      @questionnaire = questionnaire
      expect(page).to have_selector(".step-1")
      expect(page).to have_selector(".step-3")
    end

    it 'shows the user is on the next page' do
      visit_new_answer_for(questionnaire)
      @questionnaire = questionnaire

      expect(page).to have_selector("#panel0 .step-1.active")
      expect(page).to have_no_selector("#panel0 .step-2.active")
      expect(page).to have_no_selector("#panel0 .step-3.active")

      expect(page).to have_selector("#panel1 .step-1.active")
      expect(page).to have_selector("#panel1 .step-2.active")
      expect(page).to have_no_selector("#panel1 .step-3.active")

      expect(page).to have_selector("#panel2 .step-1.active")
      expect(page).to have_selector("#panel2 .step-2.active")
      expect(page).to have_selector("#panel2 .step-3.active")
    end
  end
end

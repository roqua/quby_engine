require 'spec_helper'

module Quby
  describe "quby/answers/single_page/panel" do
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

    it 'renders the questionnaire on one page' do
      visit_new_answer_for(questionnaire, "single_page")
      @questionnaire = questionnaire
      page.should_not have_selector(".step1")
      page.should_not have_selector(".step3")
      page.should have_selector("#done-button")
    end

    it 'shows all panels' do
      visit_new_answer_for(questionnaire, "single_page")
      @questionnaire = questionnaire
      page.should have_selector('.panel', count: 3)
    end
  end
end

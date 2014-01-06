require 'spec_helper'
module Quby

  describe "quby/answers/paged/panel" do
    let(:questionnaire) { Quby.questionnaire_finder.find("panels") }

    it 'renders progress bar for paged questionnaires with more than one panel' do
      visit_new_answer_for(questionnaire)
      @questionnaire = questionnaire
      page.should have_selector(".step-1")
      page.should have_selector(".step-3")
    end

  end
end

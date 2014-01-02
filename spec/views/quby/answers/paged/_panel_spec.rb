require 'spec_helper'
module Quby

  describe "quby/answers/paged/panel" do

    let(:questionnaire) { Quby.questionnaire_finder.find("panels") }

    it 'renders progress bar for paged questionnaires with more than one panel' do
      @questionnaire = questionnaire

      render partial: "quby/answers/paged/panel",
             collection: @questionnaire.panels, locals: { panels: @questionnaire.panels, questionnaire: @questionnaire }
      rendered.should include("step-1")
      rendered.should include("step-3")
    end

  end
end

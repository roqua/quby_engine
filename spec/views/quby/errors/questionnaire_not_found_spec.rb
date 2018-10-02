# frozen_string_literal: true

require "spec_helper"
describe "quby/errors/questionnaire_not_found" do

  let(:error) { Quby::Questionnaires::Repos::QuestionnaireNotFound.new 'testkey' }

  it "displays the key of the questionnaire that could not be found" do
    assign(:error, error)
    render
    expect(rendered).to match /testkey/
  end

  it "does not evaluate the questionnaire key as markdown" do
    error = Quby::Questionnaires::Repos::QuestionnaireNotFound.new "[Evil Link](evil)"
    assign(:error, error)
    render
    expect(rendered).not_to include('<a')
  end
end

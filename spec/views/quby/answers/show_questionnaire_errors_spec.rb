require "spec_helper"
require 'English'

describe "quby/answers/show_questionnaire_errors" do
  before do
    Quby.show_exceptions = true
  end
  let(:questionnaire) do
    q = Quby::Questionnaires::Entities::Questionnaire.new('key')
    q.errors.add(:definition, "all wrong")
    q
  end
  it "displays errors in the questionnaire" do
    assign(:questionnaire, questionnaire)
    render

    expect(rendered).to match /all wrong/
  end

  let(:error) { fail Quby::Questionnaires::Entities::Questionnaire::ValidationError, 'totally wrong' rescue $ERROR_INFO }

  it "displays errors passed on" do
    assign(:error, error)
    render

    expect(rendered).to match /totally wrong/
  end

  it 'Shows a vague error message when Quby.show_exceptions = false' do
    Quby.show_exceptions = false
    render

    expect(rendered).to match /Er zit een fout in de definitie van deze vragenlijst/
  end

end

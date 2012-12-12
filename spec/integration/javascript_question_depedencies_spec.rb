require 'spec_helper'

feature 'Dependencies between questions', js: true do
  # Poltergeist `should have_content('foo')` does not check that
  # foo is actually visible, so it cannot be used for our purposes
  # here. Hence the weird CSS-selector dependency that is more prone
  # to breakage if we ever change the HTML.

  scenario 'options can hide other questions' do
    questionnaire = inject_questionnaire("test", <<-END)
      panel do
      question :v1, type: :radio, required: true do
        title "Verbergt vraag 2"
        option :a1, value: 1, description: "Ja", :hides_questions => [:v2]
        option :a2, value: 2, description: "Nee"
      end; 
      
      question :v2, type: :string, required: true do
        title "Vul dit in"
      end
      end; end_panel
    END

    visit_new_answer_for(questionnaire)

    within("#item_v1") { choose "Nee" }
    find("#item_v2").find('.main').should be_visible
    within("#item_v1") { choose "Ja" }
    find("#item_v2").find('.main').should_not be_visible
  end
end
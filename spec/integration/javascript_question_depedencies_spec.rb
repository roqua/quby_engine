require 'spec_helper'

feature 'Dependencies between questions', js: true do
  # Poltergeist `should have_content('foo')` does not check that
  # foo is actually visible, so it cannot be used for our purposes
  # here. Hence the weird CSS-selector dependency that is more prone
  # to breakage if we ever change the HTML.

  context 'radio questions' do
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

      # Choosing option that hides nothing should leave other question visible
      within("#item_v1") { choose "Nee" }
      find("#item_v2").find('.main').should be_visible

      # Choosing hiding option should hide question
      within("#item_v1") { choose "Ja" }
      find("#item_v2").find('.main').should_not be_visible

      # Choosing first option again should unhide question
      within("#item_v1") { choose "Nee" }
      find("#item_v2").find('.main').should be_visible
    end
    
    scenario 'subquestions are disabled unless parent option selected' do
      questionnaire = inject_questionnaire("test", <<-END)
        question :v1, type: :radio, required: true do
          title "Verbergt vraag 2"
          option :a1, value: 1, description: "Ja"
          option :a2, value: 2, description: "Overig" do
            question :v2, type: :string, required: true do
              title 'Vul dit in'
            end
          end
        end; end_panel
      END

      visit_new_answer_for(questionnaire)

      # Choosing other option should have unrelated subquestions disabled
      within("#item_v1") { choose "Ja" }
      page.should have_css('#item_v2 #answer_v2[disabled=disabled]')

      # Choosing parent option should enable subquestions
      within("#item_v1") { choose "Overig" }
      page.should have_no_css('#item_v2 #answer_v2[disabled=disabled]')

      # Switching back to other option should disable subquestions again
      within("#item_v1") { choose "Ja" }
      page.should have_css('#item_v2 #answer_v2[disabled=disabled]')
    end
  end

  context 'checkbox questions' do
    scenario 'subquestions are disabled unless parent option selected' do
      questionnaire = inject_questionnaire("test", <<-END)
        question :v1, type: :check_box, required: true do
          title "Verbergt vraag 2"
          option :a1, value: 1, description: "Ja"
          option :a2, value: 2, description: "Overig" do
            question :v2, type: :string, required: true do
              title 'Vul dit in'
            end
          end
        end; end_panel
      END

      visit_new_answer_for(questionnaire)

      # Other options should have no effect
      within("#item_v1") { check "Ja" }
      page.should have_css('#item_v2 #answer_v2[disabled=disabled]')

      # Checking parent should enable subquestion
      within("#item_v1") { check "Overig" }
      page.should have_no_css('#item_v2 #answer_v2[disabled=disabled]')

      # Unchecking parent should disable subquestion
      within("#item_v1") { uncheck "Overig" }
      page.should have_css('#item_v2 #answer_v2[disabled=disabled]')
    end

    scenario 'uncheck_all'
    scenario 'check_all'
  end

  context 'question groups' do
    scenario 'minumum number of answered of group'
    scenario 'maximum number of answered of group'
  end
end
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
      find("#item_v2").find('.main', visible: false).should_not be_visible

      # Choosing first option again should unhide question
      within("#item_v1") { choose "Nee" }
      find("#item_v2").find('.main').should be_visible
    end

    scenario 'subquestions are disabled unless parent option selected' do
      questionnaire = inject_questionnaire("test", <<-END)
      panel do
        question :v0, type: :radio do
          option :a1, description: "Show v1", shows_questions: [:v1]
        end
        question :v1, type: :radio, required: true, default_invisible: true do
          option :a1, value: 1, description: "Ja"
          option :a2, value: 2, description: "Overig" do
            question :v2, type: :string, required: true do
              title 'Vul dit in'
            end
          end
        end;
      end
      end_panel
      END

      visit_new_answer_for(questionnaire)

      # Subquestions start out disabled
      page.should have_css('#item_v2 #answer_v2[disabled=disabled]', visible: false)

      # Unhiding a parent question should keep the question disabled
      choose "Show v1"
      page.should have_css('#item_v2 #answer_v2[disabled=disabled]')

      # Choosing other option should leave unrelated subquestions disabled
      choose "Ja"
      page.should have_css('#item_v2 #answer_v2[disabled=disabled]')

      # Choosing parent option should enable subquestions
      choose "Overig"
      page.should have_no_css('#item_v2 #answer_v2[disabled=disabled]')

      # Switching back to other option should disable subquestions again
      choose "Ja"
      page.should have_css('#item_v2 #answer_v2[disabled=disabled]')
    end

    scenario 'hiding all questions on another page skips the entire page'
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

    scenario 'options can force the unchecking of all other options' do
      questionnaire = inject_questionnaire("test", <<-END)
        question :v1, type: :check_box, uncheck_all_option: :a3 do
          title "Verbergt vraag 2"
          option :a1, value: 1, description: "One"
          option :a2, value: 2, description: "Two"
          option :a3, value: 3, description: "None"
        end; end_panel
      END

      visit_new_answer_for(questionnaire)

      check "One"
      check "Two"

      # Checking the none-option unchecks other options
      check "None"
      find('#answer_a1').should_not be_checked
      find('#answer_a2').should_not be_checked

      # Checking another option after none was selected unchecks the none-option
      check "Two"
      find('#answer_a3').should_not be_checked
    end

    scenario 'options can force the checking of all other options' do
      questionnaire = inject_questionnaire("test", <<-END)
        question :v1, type: :check_box, check_all_option: :a3 do
          title "Verbergt vraag 2"
          option :a1, value: 1, description: "One"
          option :a2, value: 2, description: "Two"
          option :a3, value: 3, description: "Both"
        end; end_panel
      END

      visit_new_answer_for(questionnaire)

      # Sanity check
      find('#answer_a1').should_not be_checked
      find('#answer_a2').should_not be_checked

      # Checking the all-option should check the other options
      check "Both"
      find('#answer_a1').should be_checked
      find('#answer_a2').should be_checked

      # Unchecking one of the checks should uncheck the all-option
      uncheck "Two"
      find('#answer_a3').should_not be_checked
    end

    scenario 'force-checking all options does not check the none-option' do
      questionnaire = inject_questionnaire("test", <<-END)
        question :v1, type: :check_box, check_all_option: :a2, uncheck_all_option: :a3 do
          title "Verbergt vraag 2"
          option :a1, value: 1, description: "One"
          option :a2, value: 2, description: "All"
          option :a3, value: 3, description: "None"
        end; end_panel
      END

      visit_new_answer_for(questionnaire)
      check "All"
      find('#answer_a1').should be_checked
      find('#answer_a3').should_not be_checked
    end
  end

  context 'question groups' do
    scenario 'minimum number of answered of group'
    scenario 'maximum number of answered of group'
  end
end
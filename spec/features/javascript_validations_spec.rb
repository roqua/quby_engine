require 'spec_helper'

feature 'Trying to fill out an invalid answer', js: true do
  # Poltergeist `should have_content('foo')` does not check that
  # foo is actually visible, so it cannot be used for our purposes
  # here. Hence the weird CSS-selector dependency that is more prone
  # to breakage if we ever change the HTML.

  scenario 'by forgetting a required scale' do
    questionnaire = inject_questionnaire("test", <<-END)
      question :v1, type: :scale, required: true do
        title "Moet beantwoord worden"
        option :a1, value: 1, description: "Ja"
        option :a2, value: 2, description: "Nee"
      end; end_panel
    END

    visit_new_answer_for(questionnaire)
    expect(find("#item_v1 .error.requires_answer", visible: false)).to_not be_visible
    click_on "Verder"
    expect(find("#item_v1 .error.requires_answer")).to be_visible
  end

  scenario 'by leaving a required string field empty' do
    questionnaire = inject_questionnaire("test", <<-END)
      question :v1, type: :string, required: true do
        title "Moet beantwoord worden"
      end; end_panel
    END

    visit_new_answer_for(questionnaire)
    filling_in(within: "#item_v1", answering: "answer_v1", with: '', should_show: '.error.requires_answer')
  end

  context "for integer questions" do
    include_examples("numerical validations", "integer")
  end

  context "for float questions" do
    include_examples("numerical validations", "float")
  end

  scenario 'by entering a number that is not a float' do
    questionnaire = inject_questionnaire("test", <<-END)
      question :v1, type: :float do
        title "Example question"
      end; end_panel
    END

    visit_new_answer_for(questionnaire)
    expect(page).to have_selector('#content')
    filling_in(within: "#item_v1", answering: "answer_v1", with: 'OHAI', should_show: '.error.valid_float')
  end

  scenario 'clientside validations are not run when aborting' do
    questionnaire = inject_questionnaire("test", <<-END)
      abortable
      question :v1, type: :float, required: true do
        title "Moet beantwoord worden"
      end; end_panel
    END

    visit_new_answer_for(questionnaire)

    fill_in 'answer_v1', with: 'INVALID'
    click_on 'Later afmaken'
    expect(page).to have_content("Uw antwoorden zijn opgeslagen")
  end

  scenario 'clientside validations are run when submitting' do
    questionnaire = inject_questionnaire("test", <<-END)
      panel do
      question :v1, type: :float, required: true do
        title "Moet beantwoord worden"
      end; end
    END

    visit_new_answer_for(questionnaire)

    within ".panel.current" do
      fill_in 'answer_v1', with: 'INVALID'
      click_on 'Klaar'
      expect(find('#item_v1 .error.valid_float')).to be_visible
      expect(page.current_path).to match(/edit\Z/)
    end
  end

  def filling_in(options = {})
    within ".panel.current" do
      expect(find(options[:within] + " " + options[:should_show], visible: false)).to_not be_visible
      fill_in options[:answering], with: options[:with]
      click_on "Verder"
      expect(find(options[:within] + " " + options[:should_show])).to be_visible
    end
  end

end

feature 'question with a depends_on', js: true do

  scenario 'is only validated when the dependee is not answered' do
    questionnaire = inject_questionnaire("depends_test", <<-END)
      panel do
        question :v1, type: :scale, required: true, depends_on: [:v2] do
          option :a1
          option :a2
        end

        question :v2, type: :check_box do
          option :v2_a, description: 'vraag 2'
        end
      end; end_panel
    END

    visit_new_answer_for(questionnaire)

    within ".panel.current" do
      check 'vraag 2'
      click_on "Verder"
      expect(find('#item_v1 .error.requires_answer', visible: false)).to be_visible

      uncheck 'vraag 2'
      click_on "Verder"
      expect(find('#item_v1 .error.requires_answer', visible: false)).to_not be_visible
    end
  end
end

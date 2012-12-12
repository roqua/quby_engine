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
    find("#item_v1 .error.requires_answer").should_not be_visible
    click_on "Volgende vraag"
    find("#item_v1 .error.requires_answer").should be_visible
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
    filling_in(within: "#item_v1", answering: "answer_v1", with: 'OHAI', should_show: '.error.valid_float')
  end

  def filling_in(options = {})
    find(options[:within] + " " + options[:should_show]).should_not be_visible
    fill_in options[:answering], with: options[:with]
    click_on "Volgende vraag"
    find(options[:within] + " " + options[:should_show]).should be_visible
  end
end

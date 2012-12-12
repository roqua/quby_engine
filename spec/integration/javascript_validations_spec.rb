require 'spec_helper'

shared_examples "numerical validations" do |numerical_type|
  let(:questionnaire) { inject_questionnaire("test", "question :v1, type: :#{numerical_type} do
                                                        title 'Example question'
                                                        validates_in_range 10..20
                                                      end; end_panel") }
  let(:too_low_value)  { 4 }
  let(:too_high_value) { 42 }
  let(:not_a_number)   { "OHAI" }

  scenario "by entering a number that is below minimum" do
    visit_new_answer_for(questionnaire)
    filling_in(within: "#item_v1", answering: "answer_v1", with: too_low_value, should_show: '.error.minimum')
  end

  scenario "by entering a number that is above maximum" do
    visit_new_answer_for(questionnaire)
    filling_in(within: "#item_v1", answering: "answer_v1", with: too_high_value, should_show: '.error.maximum')
  end

  scenario "by entering a number that is not a valid #{numerical_type}" do
    visit_new_answer_for(questionnaire)
    filling_in(within: "#item_v1", answering: "answer_v1", with: not_a_number, should_show: ".error.valid_#{numerical_type}")
  end
end

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
    find("#item_v1").should have_css(".error.requires_answer.hidden")
    click_on "Volgende vraag"
    find("#item_v1").should have_no_css(".error.requires_answer.hidden")
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
    error_css_selector = "#{options[:should_show]}.hidden"
    find(options[:within]).should have_css(error_css_selector)
    fill_in options[:answering], with: options[:with]
    click_on "Volgende vraag"
    find(options[:within]).should have_no_css(error_css_selector)
  end

  def inject_questionnaire(key, definition)
    questionnaire = Quby::Questionnaire.new(key, definition, Time.now)
    Quby.questionnaire_finder.stub(:find).with(key).and_return(questionnaire)
    questionnaire
  end
end

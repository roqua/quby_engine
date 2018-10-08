# frozen_string_literal: true

shared_examples "numerical validations" do |numerical_type|
  let(:questionnaire) do
    inject_questionnaire("test", "question :v1, type: :#{numerical_type} do
                                    title 'Example question'
                                    validates_in_range 10..20
                                  end; end_panel")
  end

  let(:too_low_value)  { 4 }
  let(:too_high_value) { 42 }
  let(:not_a_number)   { "OHAI" }

  scenario "by entering a number that is below minimum" do
    visit_new_answer_for(questionnaire)
    filling_in(within: "#item_v1", answering: "answer_v1", with: too_low_value,
               should_show: '.error.minimum')
  end

  scenario "by entering a number that is above maximum" do
    visit_new_answer_for(questionnaire)
    filling_in(within: "#item_v1", answering: "answer_v1", with: too_high_value,
               should_show: '.error.maximum')
  end

  scenario "by entering a number that is not a valid #{numerical_type}" do
    visit_new_answer_for(questionnaire)
    filling_in(within: "#item_v1", answering: "answer_v1", with: not_a_number,
               should_show: ".error.valid_#{numerical_type}")
  end
end

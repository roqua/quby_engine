require 'spec_helper'

feature 'Editing a completed answer' do
  scenario 'Opening an answer shows previous data for a select question', js: true do
    questionnaire = inject_questionnaire("test", <<-END)
      question :v_1, type: :select, required: true do
        title "A select box"
        option :a1, value: 1, description: "Ja"
        option :a2, value: 2, description: "Nee"
      end
    END

    answer = create_new_answer_for(questionnaire, 'v_1' => 'a2')
    visit_new_answer_for(questionnaire, 'paged', answer)
    find('#answer_v_1_a2')[:selected].should be_true
  end
end
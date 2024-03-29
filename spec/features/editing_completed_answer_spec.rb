# frozen_string_literal: true

require 'spec_helper'

feature 'Editing a completed answer' do
  scenario 'Opening an answer shows previous data for a select question', js: true do
    questionnaire = inject_questionnaire("test", <<-END)
      question :v_1, type: :radio, required: true do
        title "A select box"
        option :a1, value: 1, description: "Ja" do
          question :v_1_a1_val, :type => :integer, :required => true do
            title ""
          end
        end
        option :a2, value: 2, description: "Nee" do
          question :v_1_a2_val, :type => :integer, :required => true do
            title ""
          end
        end
      end
    END

    answer = create_new_answer_for(questionnaire, 'v_1' => 'a2')
    visit_new_answer_for(questionnaire, 'paged', answer)
    expect(find('#answer_v_1_a2')).to be_checked

    # make sure subquestions of selected answers are enabled
    expect(find('#answer_v_1_a2_val')[:disabled]).to eq 'false'
    expect(find('#answer_v_1_a1_val')[:disabled]).to eq 'true'
  end
end

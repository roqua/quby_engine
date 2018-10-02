# frozen_string_literal: true

require 'spec_helper'

feature 'Deselecting questions' do
  let(:questionnaire) do
    inject_questionnaire("test", <<-END)
        panel do
        question :v1, type: :radio, required: true, deselectable: false do
          option :a1, value: 1, description: "Ja"
          option :a2, value: 2, description: "Nee"
        end;

        question :v2, type: :radio, required: true do
          option :a1, value: 1, description: "Ja"
          option :a2, value: 2, description: "Nee"
        end;
        end; end_panel
    END
  end

  scenario 'disables deselecting for deselectable: false questions', js: true do
    visit_new_answer_for(questionnaire)
    choose "answer_v1_a1"
    page.should have_checked_field("answer_v1_a1")
    choose "answer_v1_a1"
    page.should have_checked_field("answer_v1_a1")
  end

  scenario 'enables deselecting by default', js: true do
    visit_new_answer_for(questionnaire)
    choose "answer_v2_a1"
    page.should have_checked_field("answer_v2_a1")
    choose "answer_v2_a1"
    page.should_not have_checked_field("answer_v2_a1")
  end
end

# frozen_string_literal: true

require 'spec_helper'

feature 'Switching to bulk view' do
  let(:questionnaire) do
    inject_questionnaire("test", <<-END)
      allow_switch_to_bulk

      panel do
        text 'This will not appear in bulk'

        question :v1, type: :radio do
          option :a1, value: 1, description: "Ja"
          option :a2, value: 2, description: "Nee"
        end
      end

      panel do
        question :v2, type: :radio do
          option :a1, value: 1, description: "Ja"
          option :a2, value: 2, description: "Nee"
        end
      end

      end_panel
    END
  end

  scenario 'switch to bulk view', js: true do
    visit_new_answer_for(questionnaire)
    expect(page).to have_content('This will not appear in bulk')
    click_link "Bulk-weergave"
    expect(page).not_to have_content('This will not appear in bulk')
  end
end


# frozen_string_literal: true

require 'spec_helper'

feature 'Switching to bulk view' do
  let(:panels) do
    <<-END
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

  let(:allow_switch_questionnaire) do
    inject_questionnaire("test", <<-END)
      allow_switch_to_bulk
      #{panels}
    END
  end

  let(:disallow_switch_questionnaire) do
    inject_questionnaire("test", <<-END)
      allow_switch_to_bulk false
      #{panels}
    END
  end

  scenario 'switch to bulk view', js: true do
    visit_new_answer_for(allow_switch_questionnaire)
    expect(page).to have_content('This will not appear in bulk')
    click_link "Bulk-weergave"
    expect(page).not_to have_content('This will not appear in bulk')
  end

  scenario 'switch only appears on the first page', js: true do
    visit_new_answer_for(allow_switch_questionnaire)
    expect(page).to have_content('This will not appear in bulk')
    click_on 'Verder'
    expect(page).not_to have_content('Bulk-weergave')
  end

  scenario 'disallowed switching to bulk view', js: true do
    visit_new_answer_for(disallow_switch_questionnaire)
    expect(page).to have_content('This will not appear in bulk')
    expect(page).not_to have_content('Bulk-weergave')
  end
end


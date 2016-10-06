require 'spec_helper'

feature 'External links' do
  let(:test_page_url) do
    "http://#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}/test.html"
  end

  let(:questionnaire) do
    inject_questionnaire("test", <<-END)
        allow_hotkeys :all
        panel do
        question :v1, type: :radio, required: true, deselectable: true do
          option :a1, value: 1, description: "~~#{test_page_url}~~Testpage~~"
          option :a2, value: 2, description: "Nee"
        end;
        end; end_panel
    END
  end

  scenario 'show page in modal window when link is clicked', js: true do
    visit_new_answer_for(questionnaire)
    click_on('Testpage')
    within_frame('modalFrame') do
      expect(current_url).to match(test_page_url)
      expect(page).to have_content('TESTING')
    end
  end
end

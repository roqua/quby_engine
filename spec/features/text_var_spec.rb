require 'spec_helper'

feature 'text_var replacement', js: true do
# Poltergeist `should have_content('foo')` does not check that
# foo is actually visible, so it cannot be used for our purposes
# here. Hence the weird CSS-selector dependency that is more prone
# to breakage if we ever change the HTML.

  scenario 'setting and changing a text_var' do
    questionnaire = inject_questionnaire("test", <<-END)
      question :v_00, :type => :string, :text_var => "middel" do
        title "Probleemmiddel: {{middel}}"
      end; end_panel
    END

    answer = create_new_answer_for(questionnaire, 'v_00' => 'init')
    visit_new_answer_for(questionnaire, 'paged', answer)

    page.should have_content 'Probleemmiddel: init'

    fill_in 'answer[v_00]', with: 'new'

    page.should have_content 'Probleemmiddel: new'
  end

  scenario 'starting with no value' do
    questionnaire = inject_questionnaire("test", <<-END)
      question :v_00, :type => :string, :text_var => "middel" do
        title "Probleemmiddel: {{middel}}"
      end; end_panel
    END

    visit_new_answer_for(questionnaire)

    page.should have_content 'Probleemmiddel: {{middel}}'
  end

end

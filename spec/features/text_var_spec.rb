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

  scenario 'setting var value from answer record' do
    questionnaire = inject_questionnaire("test", <<-END)
      textvar key: 'thing', description: 'Name of the thing'
      text "Yo dawg I herd you like {{test_thing}}s so we put a {{test_thing}} in your {{test_thing}}..."
      question :v_1, :type => :string do
        title "Foo"
      end; end_panel
    END

    answer = create_new_answer_for(questionnaire, {}, textvars: {test_thing: 'car'})
    visit_new_answer_for(questionnaire, 'paged', answer)
    page.should have_content 'Yo dawg I herd you like cars so we put a car in your car'
  end
end

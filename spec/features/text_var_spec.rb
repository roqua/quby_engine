require 'spec_helper'

feature 'textvar replacement', js: true do
  scenario 'setting and changing a textvar' do
    questionnaire = inject_questionnaire("test", <<-END)
      textvar key: 'middel', description: 'Probleemmiddel', default: '{{middel}}'

      question :v_00, :type => :string, :sets_textvar => "middel" do
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
      textvar key: 'middel', description: 'Probleemmiddel', default: '{{middel}}'

      question :v_00, :type => :string, :sets_textvar => "middel" do
        title "Probleemmiddel: {{middel}}"
      end; end_panel
    END

    visit_new_answer_for(questionnaire)
    page.should have_content 'Probleemmiddel: {{middel}}'
  end

  scenario 'starting with no default, sets {{key}} as default' do
    questionnaire = inject_questionnaire("test", <<-END)
      textvar key: 'middel', description: 'Probleemmiddel'

      question :v_00, :type => :string, :sets_textvar => "middel" do
        title "Probleemmiddel: {{middel}}"
      end; end_panel
    END

    visit_new_answer_for(questionnaire)
    page.should have_content 'Probleemmiddel: {{test_middel}}'
  end

  scenario 'setting var value from answer record' do
    questionnaire = inject_questionnaire("test", <<-END)
      textvar key: 'thing', description: 'Name of the thing'
      panel do

        question :v_1, type: :string, sets_textvar: 'thing', title: 'What do you like?'

        text "Yo dawg I herd you like {{thing}}s so we put a {{thing}} in your {{thing}}..."

      end
    END

    answer = create_new_answer_for(questionnaire, {}, textvars: {test_thing: 'car'})
    visit_new_answer_for(questionnaire, 'paged', answer)
    # sets the variable in the any markdown enabled text.
    page.should have_content 'Yo dawg I herd you like cars so we put a car in your car'
    # sets the value of input with sets_textvar to the textvar if given.
    page.should have_field("answer_v_1", text: 'car')
  end

  scenario 'showing default var value' do
    questionnaire = inject_questionnaire("test", <<-END)
      textvar key: 'thing', description: 'Name of the thing', default: 'car'

      text "Yo dawg I herd you like {{thing}}s so we put a {{thing}} in your {{thing}}..."

      question :v_1, :type => :string do
        title "Foo"
      end; end_panel
    END

    answer = create_new_answer_for(questionnaire, {})
    visit_new_answer_for(questionnaire, 'paged', answer)
    page.should have_content 'Yo dawg I herd you like cars so we put a car in your car'
  end

  scenario 'creating without value' do
    questionnaire = inject_questionnaire("test", <<-END)
      textvar key: 'thing', description: 'Name of the thing'

      text "Yo dawg I herd you like {{thing}}s so we put a {{thing}} in your {{thing}}..."

      question :v_1, :type => :string do
        title "Foo"
      end; end_panel
    END

    answer = create_new_answer_for(questionnaire, {})
    visit_new_answer_for(questionnaire, 'paged', answer)
    page.should have_content 'Yo dawg I herd you like {{test_thing}}s so we put a {{test_thing}} in your {{test_thing}}'
  end
end

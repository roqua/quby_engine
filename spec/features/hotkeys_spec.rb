require 'spec_helper'

feature 'Using hotkeys' do
  let(:questionnaire) do
    inject_questionnaire("test", <<-END)
        allow_hotkeys :all
        panel do
        question :v1, type: :radio, required: true, deselectable: true do
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

  scenario 'can select options with space', js: true do
    visit_new_answer_for(questionnaire)
    keypress_script = "var e = jQuery.Event( 'keyup' ); e.which = $.ui.keyCode.SPACE; $('#answer_v1_a1').trigger(e);"
    page.driver.execute_script(keypress_script)

    page.should have_checked_field("answer_v1_a1")
  end

  scenario 'can select options by pressing their number value', js: true do
    visit_new_answer_for(questionnaire)
    # 49 is keycode for the character 1
    keypress_script = "var e = jQuery.Event( 'keyup' ); e.which = 49; $('#answer_v1_a1').trigger(e);"
    page.driver.execute_script(keypress_script)
    page.should have_checked_field("answer_v1_a1")
  end
end

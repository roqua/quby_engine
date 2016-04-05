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

  let(:keypress_space) { "var e = jQuery.Event( 'keyup' ); e.which = $.ui.keyCode.SPACE; $('#item_v1').trigger(e);" }
  let(:keypress_1) { "var e = jQuery.Event( 'keyup' ); e.which = 49; $('#item_v1').trigger(e);" }
  let(:keypress_up) { "var e = jQuery.Event( 'keydown' ); e.which = 33; $('#item_v1').trigger(e);" }
  let(:keypress_2) { "var e = jQuery.Event( 'keyup' ); e.which = 50; $('#item_v1').trigger(e);" }

  scenario 'can select options with space', js: true do
    visit_new_answer_for(questionnaire)

    page.driver.execute_script(keypress_space)
    expect(page).to have_checked_field("answer_v1_a1")

    page.driver.execute_script(keypress_up)
    wait_until_focussed("#answer_v1_a1")

    page.driver.execute_script(keypress_2)
    expect(page).to have_checked_field("answer_v1_a2")

    page.driver.execute_script(keypress_up)
    wait_until_focussed("#answer_v1_a1")

    page.driver.execute_script(keypress_space)
    expect(page).to have_checked_field("answer_v1_a1")
  end

  scenario 'can select options by pressing their number value', js: true do
    visit_new_answer_for(questionnaire)

    page.driver.execute_script(keypress_1)
    expect(page).to have_checked_field("answer_v1_a1")

    page.driver.execute_script(keypress_up)
    wait_until_focussed("#answer_v1_a1")

    page.driver.execute_script(keypress_2)
    expect(page).to have_checked_field("answer_v1_a2")

    page.driver.execute_script(keypress_up)
    wait_until_focussed("#answer_v1_a1")

    page.driver.execute_script(keypress_1)
    expect(page).to have_checked_field("answer_v1_a1")
  end
end

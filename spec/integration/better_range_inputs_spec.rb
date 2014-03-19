require 'spec_helper'

feature 'Displaying a input of type range', js: true do

  def input
    find("#answer_v1", visible: false)
  end

  def slider
    find("#answer_v1+.noUi-target", visible: false)
  end

  def slider_value
    page.evaluate_script("$('#answer_v1+.noUi-target').val()")
  end

  scenario 'A float slider without a (default) value set' do
    questionnaire = inject_questionnaire("test", <<-END)
      question :v1, type: :float, presentation: :horizontal, as: :slider do
        title "Relatie/Contact"
        validates_in_range 0..100
        left_label "left"
        right_label "right"
      end; end_panel
    END
    visit_new_answer_for(questionnaire)

    input.should_not be_visible
    slider.should be

    input.value.should eq ''
    slider_value.should eq '50.00'
    input['class'].should include 'invalid'

    # default is not to have a tooltip
    page.should_not have_css('.noUi-value', visible: false)

    # if the input is disabled, the slider should be as well (and back)
    page.evaluate_script('$("#answer_v1").prop("disabled", true)')
    find("#answer_v1+.noUi-target[disabled]").should be
    page.evaluate_script('$("#answer_v1").prop("disabled", false)')
    find("#answer_v1+.noUi-target:not([disabled])").should be

    # tap the slider should change the value
    pos = page.evaluate_script("$('#answer_v1+.noUi-target .noUi-base').position()")
    page.driver.click(pos['left'] + 100, pos['top'] + 5)
    slider_value.to_i.should be < 40
    slider_value.to_i.should be > 10
    input.value.should eq slider_value

    # the input should not be invalid after the user set a value
    input['class'].should_not include 'invalid'

    # dragging the slider should change the value
    # can't test this yet.
  end

  let(:default_value) { 40 }

  scenario 'A float slider with a default set with a tooltip' do
    questionnaire = inject_questionnaire("test", <<-END)
      default_answer_value({v1: #{default_value}})
      question :v1, type: :integer, presentation: :horizontal, as: :slider,
                    value_tooltip: true do
        title "Relatie/Contact"
        validates_in_range 0..100
        left_label "left"
        right_label "right"
      end; end_panel
    END
    visit_new_answer_for(questionnaire)

    input.value.to_i.should eq default_value
    slider_value.to_i.should eq default_value
    find('.noUi-value', visible: false).should have_content(default_value)

    slider['class'].should_not include 'invalid'

  end

  scenario 'A slider with show_values set' do
    questionnaire = inject_questionnaire("test", <<-END)
      question :v1, type: :integer, presentation: :horizontal, as: :slider,
                    show_values: true do
        title "Relatie/Contact"
      end; end_panel
    END
    visit_new_answer_for(questionnaire)

    input.should be_visible
  end

end

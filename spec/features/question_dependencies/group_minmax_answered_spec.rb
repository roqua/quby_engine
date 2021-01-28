# frozen_string_literal: true

require 'spec_helper'

shared_examples 'group_minmax_answered_tests' do
  it 'is valid when radio question is not filled in' do
    # select_radio_option 'v_radio', 'a1'
    select_radio_option 'v_scale', 'a1'
    set_slider_value 'v_slider', '50'
    run_validations
    expect_no_errors
    # expect_saved_value 'v_radio', 'a1'
    expect_saved_value 'v_scale', 'a1'
  end

  it 'is valid when scale question is not filled in' do
    select_radio_option 'v_radio', 'a1'
    # select_radio_option 'v_scale', 'a1'
    set_slider_value 'v_slider', '50'
    run_validations
    expect_no_errors
    expect_saved_value 'v_radio', 'a1'
    # expect_saved_value 'v_scale', 'a1'
  end

  it 'is valid when slider question is not filled in' do
    select_radio_option 'v_radio', 'a1'
    select_radio_option 'v_scale', 'a1'
    # set_slider_value 'v_slider', '50'
    run_validations
    expect_no_errors
    expect_saved_value 'v_radio', 'a1'
    expect_saved_value 'v_scale', 'a1'
  end

  it 'is not valid when no questions are filled' do
    # select_radio_option 'v_radio', 'a1'
    # select_radio_option 'v_scale', 'a1'
    # set_slider_value 'v_slider', '50'
    run_validations
    expect_error_on 'v_radio', 'answer_group_minimum'
    expect_error_on 'v_scale', 'answer_group_minimum'
  end

  it 'is not valid when only one question is filled' do
    select_radio_option 'v_radio', 'a1'
    # select_radio_option 'v_scale', 'a1'
    # set_slider_value 'v_slider', '50'
    run_validations
    expect_error_on 'v_radio', 'answer_group_minimum'
    expect_error_on 'v_scale', 'answer_group_minimum'
  end

  it 'is not valid when all questions are filled' do
    select_radio_option 'v_radio', 'a1'
    select_radio_option 'v_scale', 'a1'
    set_slider_value 'v_slider', '50'
    run_validations
    expect_error_on 'v_radio', 'answer_group_maximum'
    expect_error_on 'v_scale', 'answer_group_maximum'
  end
end

shared_examples 'group_minmax_answered' do
  before do
    allow_server_side_validation_error
  end
  context 'normal' do
    let(:questionnaire) do
      inject_questionnaire 'test', <<-END
        n = 2

        panel do
          question :v_radio, type: :radio, question_group: :group1, group_minimum_answered: n,
                                                                    group_maximum_answered: n do
            title 'Radio Question'
            option :a1, value: 1, description: "Radio Option 1"
            option :a2, value: 2, description: "Radio Option 2"
          end

          question :v_scale, type: :scale, question_group: :group1, group_minimum_answered: n,
                                                                    group_maximum_answered: n do
            title 'Scale Question'
            option :a1, value: 1, description: "Scale Option 1"
            option :a2, value: 2, description: "Scale Option 2"
          end

          question :v_slider, type: :float, as: :slider, size: 20, default_position: :hidden,
                            question_group: :group1, group_minimum_answered: n,
                                                     group_maximum_answered: n do
            title "Slider"
            validates_in_range 0..100
          end
        end; end_panel
      END
    end

    it_behaves_like 'group_minmax_answered_tests'
  end

  context 'table-based' do
    let(:questionnaire) do
      inject_questionnaire 'test', <<-END
      n = 2

      panel do
        table columns: 20 do
          question :v_radio, type: :radio, question_group: :group1, group_minimum_answered: n,
                                                                    group_maximum_answered: n do
            title 'Radio Question'
            option :a1, value: 1, description: "Radio Option 1"
            option :a2, value: 2, description: "Radio Option 2"
          end

          question :v_scale, type: :scale, question_group: :group1, group_minimum_answered: n,
                                                                    group_maximum_answered: n do
            title 'Scale Question'
            option :a1, value: 1, description: "Scale Option 1"
            option :a2, value: 2, description: "Scale Option 2"
          end
        end

        question :v_slider, type: :float, as: :slider, size: 20, default_position: :hidden,
                            question_group: :group1, group_minimum_answered: n,
                                                     group_maximum_answered: n do
          title "Slider"
          validates_in_range 0..100
        end
      end
      end_panel
      END
    end

    it_behaves_like 'group_minmax_answered_tests'
  end
end

feature 'Client-side validations for group minimum and maximum answered', js: true do
  include ClientSideValidationHelpers
  it_behaves_like "group_minmax_answered"
end

feature 'Server-side validations for group minimum and maximum answered' do
  include ServerSideValidationHelpers
  it_behaves_like "group_minmax_answered"
end

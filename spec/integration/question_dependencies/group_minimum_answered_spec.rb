require 'spec_helper'

shared_examples 'group_minimum_answered' do
  context 'minimum number of given answers in a group' do
    let(:questionnaire) do
      inject_questionnaire 'test', <<-END
        n = 5

        panel do
          question :v_radio, type: :radio, question_group: :group1, group_minimum_answered: n do
            title 'Radio Question'
            option :a1, value: 1, description: "Radio Option 1"
            option :a2, value: 2, description: "Radio Option 2"
          end

          question :v_check_box, type: :check_box, question_group: :group1, group_minimum_answered: n do
            title "Pick one"
            option :v_ck_a1, value: 1, description: 'Unicorns'
            option :v_ck_a2, value: 2, description: 'Rainbows'
          end

          question :v_string, type: :string, question_group: :group1, group_minimum_answered: n do
            title 'String Question'
          end

          question :v_integer, type: :integer, question_group: :group1, group_minimum_answered: n do
            title 'Integer Question'
          end

          question :v_float, type: :float, question_group: :group1, group_minimum_answered: n do
            title 'Float Question'
          end

        end; end_panel
      END
    end

    it 'is valid when all questions are filled in' do
      select_radio_option 'v_radio', 'a1'
      check_option 'v_ck_a1'
      fill_in_question 'v_string', 'kittens!'
      fill_in_question 'v_integer', '37'
      fill_in_question 'v_float', '4.2'
      run_validations
      expect_no_errors
      expect_saved_value 'v_radio', 'a1'
      expect_saved_value 'v_check_box', {'v_ck_a1' => 1}
      expect_saved_value 'v_string', 'kittens!'
      expect_saved_value 'v_integer', "37"
      expect_saved_value 'v_float', "4.2"
    end
  end
end

feature 'Client-side validations on date questions', js: true do
  include ClientSideValidationHelpers
  it_behaves_like "group_minimum_answered"
end

feature 'Server-side validations on date questions' do
  include ServerSideValidationHelpers
  it_behaves_like "group_minimum_answered"
end

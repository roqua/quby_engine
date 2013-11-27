require 'spec_helper'

shared_examples "validations on float questions" do
  context 'requires_answer validation' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_float, type: :float, required: true do
          title "Enter a float"
        end; end_panel
      END
    end

    scenario 'saving a valid float' do
      fill_in_question('v_float', '1.2')
      run_validations
      expect_no_errors
      expect_saved_value 'v_float', '1.2'
    end

    scenario 'saving an integer into a float field' do
      fill_in_question 'v_float', '1'
      run_validations
      expect_no_errors
    end

    scenario 'saving an invalid float' do
      fill_in_question 'v_float', 'foo'
      run_validations
      expect_error_on 'v_float', 'valid_float'

      fill_in_question 'v_float', ''
      run_validations
      expect_error_on 'v_float', 'requires_answer'
    end
  end

  context 'in_range validation' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_float, type: :float do
          title "Enter a date"
          validates_in_range 10..20
        end; end_panel
      END
    end

    scenario 'saving a valid float' do
      fill_in_question('v_float', '15')
      run_validations
      expect_no_errors
    end

    scenario 'saving no float' do
      fill_in_question('v_float', '')
      run_validations
      expect_no_errors
    end

    scenario 'saving a too-low float' do
      fill_in_question('v_float', '5')
      run_validations
      expect_error_on 'v_float', 'minimum'
    end

    scenario 'saving a too-high float' do
      fill_in_question('v_float', '25')
      run_validations
      expect_error_on 'v_float', 'maximum'
    end

    scenario 'saving an invalid float' do
      fill_in_question('v_float', 'foo')
      run_validations
      expect_error_on 'v_float', 'valid_float'
    end
  end
end

feature 'Client-side validations on float questions', js: true do
  include ClientSideValidationHelpers
  before { @answer = visit_new_answer_for(questionnaire) }
  it_behaves_like "validations on float questions"
end

feature 'Server-side validations on float questions' do
  include ServerSideValidationHelpers
  let(:answer) { Quby::Answer.create(questionnaire_key: questionnaire.key) }
  let(:updates_answers) { Quby::UpdatesAnswers.new(answer) }
  let(:answer_to_submit) { {} }
  it_behaves_like "validations on float questions"
end
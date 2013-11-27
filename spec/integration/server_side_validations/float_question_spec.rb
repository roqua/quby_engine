require 'spec_helper'

feature 'Server-side validations for float questions' do
  include ServerSideValidationHelpers

  let(:answer) { Quby::Answer.create(questionnaire_key: questionnaire.key) }
  let(:updates_answers) { Quby::UpdatesAnswers.new(answer) }
  let(:answer_to_submit) { {} }

  context 'requires_answer validation' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_float, type: :float, required: true do
          title "Enter a float"
        end; end_panel
      END
    end

    scenario 'saving a valid float' do
      fill_in_question 'v_float', '1.2'
      run_validations
      expect_no_errors
      expect_saved_value 'v_float', '1.2'
    end

    scenario 'saving an integer into a float field' do
      fill_in_question 'v_float', '1'
      run_validations
      expect_no_errors
      expect_saved_value 'v_float', '1'
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
      updates_answers.update('v_float' => '15')
      answer.errors.should_not be_present
      answer.reload.v_float.should == '15'
    end

    scenario 'saving an empty value' do
      updates_answers.update('v_float' => '')
      answer.errors[:v_float].should_not be_present
    end

    scenario 'saving a too-low float' do
      updates_answers.update('v_float' => '5')
      answer.errors[:v_float].should eq([{message: 'Smaller than minimum', valtype: :minimum}])
    end

    scenario 'saving a too-high float' do
      updates_answers.update('v_float' => '25')
      answer.errors[:v_float].should eq([{message: 'Exceeds maximum', valtype: :maximum}])
    end

    scenario 'saving an invalid float' do
      updates_answers.update('v_float' => 'foo')
      answer.errors[:v_float].should be_present
    end
  end
end
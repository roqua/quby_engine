require 'spec_helper'

feature 'Integer questions' do
  let(:answer) { Quby::Answer.create(questionnaire_key: questionnaire.key) }
  let(:updates_answers) { Quby::UpdatesAnswers.new(answer) }

  context 'requires_answer validation' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_integer, type: :integer, required: true do
          title "Enter a integer"
        end
      END
    end

    scenario 'saving a valid integer' do
      updates_answers.update('v_integer' => '1')
      answer.errors.should_not be_present
      answer.reload.v_integer.should == '1'
    end

    scenario 'saving a float into integer field' do
      updates_answers.update('v_integer' => '1.2')
      answer.errors[:v_integer].should be_present
    end

    scenario 'saving an invalid integer' do
      updates_answers.update('v_integer' => 'foo')
      answer.errors[:v_integer].should be_present

      answer.errors.clear
      updates_answers.update('v_integer' => '')
      answer.errors[:v_integer].should be_present
    end
  end

  context 'in_range validation' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_integer, type: :integer do
          title "Enter a date"
          validates_in_range 10..20
        end
      END
    end

    scenario 'saving a valid integer' do
      updates_answers.update('v_integer' => '15')
      answer.errors.should_not be_present
      answer.reload.v_integer.should == '15'
    end

    scenario 'saving a too-low integer' do
      updates_answers.update('v_integer' => '5')
      answer.errors[:v_integer].should eq([{message: 'Smaller than minimum', valtype: :minimum}])
    end

    scenario 'saving a too-high integer' do
      updates_answers.update('v_integer' => '25')
      answer.errors[:v_integer].should eq([{message: 'Exceeds maximum', valtype: :maximum}])
    end

    scenario 'saving an invalid integer' do
      updates_answers.update('v_integer' => 'foo')
      answer.errors[:v_integer].should be_present

      answer.errors.clear
      updates_answers.update('v_integer' => '')
      answer.errors[:v_integer].should be_present
    end
  end
end
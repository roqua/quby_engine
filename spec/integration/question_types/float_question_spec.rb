require 'spec_helper'

feature 'Float questions' do
  let(:answer) { Quby::Answer.create(questionnaire_key: questionnaire.key) }
  let(:updates_answers) { Quby::UpdatesAnswers.new(answer) }

  context 'requires_answer validation' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_float, type: :float, required: true do
          title "Enter a float"
        end
      END
    end

    scenario 'saving a valid float' do
      updates_answers.update('v_float' => '1.2')
      answer.errors.should_not be_present
      answer.reload.v_float.should == '1.2'
    end

    scenario 'saving an integer into a float field' do
      updates_answers.update('v_float' => '1')
      answer.errors.should_not be_present
      answer.reload.v_float.should == '1'
    end

    scenario 'saving an invalid float' do
      updates_answers.update('v_float' => 'foo')
      answer.errors[:v_float].should be_present

      answer.errors.clear
      updates_answers.update('v_float' => '')
      answer.errors[:v_float].should be_present
    end
  end

  context 'in_range validation' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_float, type: :float do
          title "Enter a date"
          validates_in_range 10..20
        end
      END
    end

    scenario 'saving a valid float' do
      updates_answers.update('v_float' => '15')
      answer.errors.should_not be_present
      answer.reload.v_float.should == '15'
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

      answer.errors.clear
      updates_answers.update('v_float' => '')
      answer.errors[:v_float].should be_present
    end
  end
end
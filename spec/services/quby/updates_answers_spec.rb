require 'spec_helper'

module Quby
  describe UpdatesAnswers do
    let(:answer) { Quby.answer_repo.create!('big') }
    let(:updates_answers) { UpdatesAnswers.new answer }

    describe '#update' do
      it 'sets the raw parameters on the answer' do
        updates_answers.update("v_6" => "value", 'unknown_field' => 'value_should_be_retained')
        Quby.answer_repo.reload(answer).raw_params["unknown_field"].should == "value_should_be_retained"
      end

      it 'sets answer value for the provided key to the provided value' do
        updates_answers.update("v_6" => "value")
        Quby.answer_repo.reload(answer).attributes["value"]["v_6"].should == "value"
      end

      it 'disallows setting attributes that are not questions' do
        updates_answers.update("random_key" => "value")
        Quby.answer_repo.reload(answer).attributes["random_key"].should_not == "value"
      end

      it 'validates the answer' do
        answer.should_receive :validate_answers
        updates_answers.update
      end

      it 'cleans up the answer' do
        answer.should_receive :cleanup_input
        updates_answers.update
      end

      it 'sets the completed_at' do
        answer.should_receive :set_completed_at
        updates_answers.update
      end

      it 'calculates scores' do
        outcome = Outcome.new
        calculations = OutcomeCalculations.new(answer)
        OutcomeCalculations.stub(:new).with(answer).and_return(calculations)
        calculations.should_receive(:calculate_builders).and_return(outcome)
        updates_answers.update
      end
    end
  end
end

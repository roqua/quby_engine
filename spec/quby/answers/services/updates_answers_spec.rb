require 'spec_helper'

module Quby::Answers::Services
  describe UpdatesAnswers do
    let(:answer) { Quby.answers.create!('simple') }
    let(:updates_answers) { UpdatesAnswers.new answer }

    describe '#update' do
      it 'sets the raw parameters on the answer' do
        updates_answers.update("v_1" => "value", 'unknown_field' => 'value_should_be_retained')
        expect(Quby.answers.reload(answer).raw_params["unknown_field"]).to eq "value_should_be_retained"
      end

      it 'sets answer value for the provided key to the provided value' do
        updates_answers.update("v_1" => "value")
        expect(Quby.answers.reload(answer).attributes["value"]["v_1"]).to eq "value"
      end

      it 'disallows setting attributes that are not questions' do
        updates_answers.update("random_key" => "value")
        expect(Quby.answers.reload(answer).attributes["random_key"]).to_not eq "value"
      end

      it 'validates the answer' do
        expect(answer).to receive :validate_answers
        updates_answers.update
      end

      it 'cleans up the answer' do
        expect(answer).to receive :cleanup_input
        updates_answers.update
      end

      it 'sets the started_at and completed_at' do
        started_at = Time.new(2014, 2, 4, 5, 6, 7)
        expect(answer).to receive(:mark_completed).with(started_at)
        updates_answers.update("rendered_at" => started_at.to_i.to_s)
      end

      it 'calculates scores' do
        outcome = Quby::Answers::Entities::Outcome.new
        calculations = OutcomeCalculation.new(answer)
        allow(OutcomeCalculation).to receive(:new).with(answer).and_return(calculations)
        expect(calculations).to receive(:calculate).and_return(outcome)
        updates_answers.update
      end
    end
  end
end

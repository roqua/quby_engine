require 'spec_helper'

module Quby
  describe UpdatesAnswers do
    let(:answer) { Answer.new(questionnaire_key: 'big') }
    let(:updates_answers) { UpdatesAnswers.new answer }

    describe '#update' do
      it 'sets answer value for the provided key to the provided value' do
        updates_answers.update("v_6" => "value")
        answer.reload.attributes["value"]["v_6"].should == "value"
      end

      it 'disallows setting attributes that are not questions' do
        updates_answers.update("random_key" => "value")
        answer.reload.attributes["random_key"].should_not == "value"
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
        answer.should_receive :calculate_builders
        updates_answers.update
      end
    end
  end
end

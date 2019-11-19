# frozen_string_literal: true

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

      context 'subquestion key clash' do
        let(:answer) { Quby.answers.create!('subquestion_key_clash') }
        it 'does not remove filtered values from raw_params' do
          updates_answers.update('v_0' => 'a1', 'v_0_a1' => "value")
          expect(Quby.answers.reload(answer).raw_params["v_0_a1"]).to eq("value")
        end
      end

      context 'if the answer cannot be updated correctly' do
        before do
          answer.send :add_error, double(key: :v_0), :valid_integer, "Oh no, ERROR!"
          allow_server_side_validation_error(always: true)
        end

        it 'reports the error' do
          expect(Roqua::Support::Errors).to receive(:report) do |error|
            expect(error).to be_a(Quby::ValidationError)
            expect(error.message).to eq('["V 0 {:message=>\"Oh no, ERROR!\", :valtype=>:valid_integer}"]')
          end
          updates_answers.update('v_0' => 'value')
        end
      end

      it 'validates the answer' do
        expect(answer).to receive :validate_answers
        updates_answers.update
      end

      it 'cleans up the answer' do
        expect(answer).to receive :cleanup_input
        updates_answers.update
      end

      it 'calls mark_completed with the started_at time' do
        started_at = Time.new(2014, 2, 4, 5, 6, 7)
        expect(answer).to receive(:mark_completed).with(start_time: started_at)
        updates_answers.update("rendered_at" => started_at.to_i.to_s)
      end

      it 'calculates scores' do
        outcome = Quby::Answers::Entities::Outcome.new
        calculations = OutcomeCalculation.new(answer)
        allow(OutcomeCalculation).to receive(:new).and_return(calculations)
        expect(calculations).to receive(:calculate).and_return(outcome)
        updates_answers.update
      end
    end
    describe 'always saving raw_params' do
      it 'saves raw_params if there is an exception during cleanup_input' do
        Timecop.freeze do
          expect(answer).to receive(:cleanup_input).and_raise(ArgumentError)
          expect { updates_answers.update('v_1' => 'a1') }.to raise_exception(ArgumentError)
          expect(answer.raw_params).to eq('v_1' => 'a1', 'could_not_update_at' => Time.now.to_i)
        end
      end
    end

    describe 'using observation_time as a timestamp in calculations' do
      # age calculation in scores requires observation_time to be set through the mark_completed method
      it 'sets observation_time before assigning OutcomeCalculation.new(answer).calculate' do
        expect(answer).to receive(:mark_completed).ordered
        expect(answer).to receive(:outcome=).ordered
        updates_answers.update('v_1' => 'a1')
      end
    end
  end
end

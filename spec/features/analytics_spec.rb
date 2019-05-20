# frozen_string_literal: true

require 'spec_helper'

feature 'Analytics' do
  describe 'Timing how long completing a questionnaire took' do
    let(:questionnaire) { Quby.questionnaires.find("simple") }

    it 'stores the first time the answer was opened' do
      answer         = nil
      time_opened    = Time.new(2014, 4, 1, 12, 23, 32)
      time_completed = Time.new(2014, 4, 1, 12, 25, 11)

      Timecop.freeze(time_opened) do
        answer = visit_new_answer_for(questionnaire)
      end

      Timecop.freeze(time_completed) do
        choose "answer_v_1_a1"
        click_on "Klaar"
        expect(page).to have_content("Uw antwoorden zijn opgeslagen")
      end

      expect(Quby.answers.reload(answer).started_at).to   eq(time_opened)
      expect(Quby.answers.reload(answer).completed_at).to eq(time_completed)
    end
  end
end

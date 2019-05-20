# frozen_string_literal: true

# -*- coding: utf-8 -*-
require 'spec_helper'

module Quby
  describe AnswersController do
    include EngineControllerTesting

    let(:answer)        { double("Answer", id: '1', token: 'answer_token') }
    let(:questionnaire) { double("Questionnaire", key: 'honos', renderer_version: :v1, errors: [], questions: []) }

    before do
      allow(Quby.questionnaires).to receive(:find).and_return(questionnaire)
      allow(Quby.answers).to receive(:find).with('honos', '1').and_return(answer)
      allow(Quby::Settings).to receive(:authorize_with_id_from_session).and_return(false)
      allow(Quby::Settings).to receive(:shared_secret).and_return("something_long_and_random")
    end

    describe 'HMAC check on show' do
      let(:timestamp) { Time.now.strftime("%Y-%m-%dT%H:%M:%S 00:00") }

      def hmac(secret = Quby::Settings.shared_secret)
        plain_hmac = [secret, answer.token, timestamp].join('|')
        Digest::SHA1.hexdigest(plain_hmac)
      end

      it 'allows correct hmacs' do
        get :edit, questionnaire_id: 'honos', id: answer.id, token: answer.token, hmac: hmac, timestamp: timestamp
        expect(response).to render_template('v1/paged')
      end

      it 'allows correct hmacs from previous secret' do
        allow(Quby::Settings).to receive(:previous_shared_secret).and_return('old_secret')
        get :edit, questionnaire_id: 'honos', id: answer.id, token: answer.token, hmac: hmac('old_secret'),
                   timestamp: timestamp
        expect(response).to render_template('v1/paged')
      end

      it 'raises when no hmac is given' do
        expect do
          get :edit, questionnaire_id: 'honos', id: answer.id, token: answer.token, timestamp: timestamp
        end.to raise_error(TokenValidationError)
      end

      it 'raises when wrong hmac is given' do
        expect do
          get :edit, questionnaire_id: 'honos', id: answer.id, token: answer.token, timestamp: timestamp, hmac: 'wrong'
        end.to raise_error(TokenValidationError)
      end

      it 'raises when wrong hmac is given when previous secret is configured' do
        allow(Quby::Settings).to receive(:previous_shared_secret).and_return('old_secret')
        expect do
          get :edit, questionnaire_id: 'honos', id: answer.id, token: answer.token, timestamp: timestamp, hmac: 'wrong'
        end.to raise_error(TokenValidationError)
      end

      it 'raises when HMAC is not configured' do
        allow(Quby::Settings).to receive(:shared_secret).and_return(nil)
        expect do
          get :edit, questionnaire_id: 'honos', id: answer.id, token: answer.token, timestamp: timestamp
        end.to raise_error(TokenValidationError)
      end

      it 'checks timestamp validity before checking the hmac validity' do
        expect do
          get :edit, questionnaire_id: 'honos', id: answer.id, token: answer.token, hmac: hmac, timestamp: "fake"
        end.to raise_error(TimestampValidationError)
      end

      it 'redirects to roqua if the timestamp is expired' do
        get :edit, questionnaire_id: 'honos', id: answer.id,
                   token: answer.token,
                   hmac: hmac,
                   timestamp: 1.day.ago.strftime("%Y-%m-%dT%H:%M:%S+00:00"),
                   return_token: 'asdf',
                   return_url: "/evaluate/collect_answers"
        expect(response).to redirect_to("/evaluate/collect_answers?error=Quby%3A%3ATimestampExpiredError" \
                                        "&key=asdf&return_from=quby&return_from_answer=#{answer.id}" \
                                        "&status=error")
      end
    end
  end
end

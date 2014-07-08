# -*- coding: utf-8 -*-
require 'spec_helper'

module Quby
  describe AnswersController do
    include EngineControllerTesting

    let(:answer)        { double("Answer", id: '1', token: 'answer_token') }
    let(:questionnaire) { double("Questionnaire", key: 'honos', renderer_version: :v1, errors: []) }

    before do
      Quby.questionnaires.stub(find: questionnaire)
      Quby.answers.stub(:find).with('honos', '1').and_return(answer)
      Quby::Settings.stub(authorize_with_id_from_session: false)
      Quby::Settings.stub(shared_secret: "something_long_and_random")
    end

    describe 'HMAC check on show' do
      let(:timestamp) { Time.now.strftime("%Y-%m-%dT%H:%M:%S 00:00") }
      let(:hmac) do
        token = answer.token
        plain_hmac = [Quby::Settings.shared_secret, token, timestamp].join('|')
        Digest::SHA1.hexdigest(plain_hmac)
      end

      it 'allows correct hmacs' do
        get :edit, questionnaire_id: 'honos', id: answer.id, token: answer.token, hmac: hmac, timestamp: timestamp
        expect(response).to render_template('v1/paged')
      end

      it 'Facebook spider does not report' do
        get :edit, questionnaire_id: 'honos', id: answer.id, token: answer.token, hmac: hmac,
                   timestamp: timestamp.gsub(" ", "EB_PLUS")
        expect(response).to render_template('errors/generic')
      end

      it 'raises when no hmac is given' do
        expect do
          get :edit, questionnaire_id: 'honos', id: answer.id, token: answer.token, timestamp: timestamp
        end.to raise_error(AnswersController::TokenValidationError)
      end

      it 'raises when HMAC is not configured' do
        Quby::Settings.stub(shared_secret: nil)
        expect do
          get :edit, questionnaire_id: 'honos', id: answer.id, token: answer.token, timestamp: timestamp
        end.to raise_error(AnswersController::TokenValidationError)
      end

      it 'checks timestamp validity before checking the hmac validity' do
        expect do
          get :edit, questionnaire_id: 'honos', id: answer.id, token: answer.token, hmac: hmac, timestamp: "fake"
        end.to raise_error(AnswersController::TimestampValidationError)
      end

      it 'redirects to roqua if the timestamp is expired' do
        get :edit, questionnaire_id: 'honos', id: answer.id,
                   token: answer.token,
                   hmac: hmac,
                   timestamp: 1.day.ago.strftime("%Y-%m-%dT%H:%M:%S+00:00"),
                   return_token: 'asdf',
                   return_url: "/evaluate/collect_answers"
        expect(response).to redirect_to("/evaluate/collect_answers?expired_session=true" \
                                        "&key=asdf&return_from=quby&return_from_answer=#{answer.id}")
      end
    end
  end
end

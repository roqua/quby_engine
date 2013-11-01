# -*- coding: utf-8 -*-
require 'spec_helper'

module Quby
  describe AnswersController do
    before do
      finder = stub(find: Questionnaire.new("honos"))
      Quby.stub(questionnaire_finder: finder)
    end

    let(:answer) { Quby::Answer.create(questionnaire_key: "honos") }

    describe 'HMAC check on show' do
      let(:timestamp) { Time.now.strftime("%Y-%m-%dT%H:%M:%S 00:00") }
      let(:hmac) do
        token = answer.token
        plain_hmac = [Quby::Settings.shared_secret, token, timestamp].join('|')
        Digest::SHA1.hexdigest(plain_hmac)
      end

      it 'allows correct hmacs' do
        expect do
          get "/quby/questionnaires/honos/answers/#{answer.id}/edit", token: answer.token,
                                                                      hmac: hmac, timestamp: timestamp
        end.not_to raise_error
      end

      it 'Facebook spider does not report' do
        expect do
          get "/quby/questionnaires/honos/answers/#{answer.id}/edit", token: answer.token,
                                                                      hmac: hmac,
                                                                      timestamp: timestamp.gsub(" ", "EB_PLUS")
        end.not_to raise_error
      end

      it 'raises when no hmac is given' do
        expect do
          get "/quby/questionnaires/honos/answers/#{answer.id}/edit", token: answer.token,
                                                                      timestamp: timestamp
        end.to raise_error(AnswersController::TokenValidationError)
      end

      it 'checks timestamp validity before checking the hmac validity' do
        expect do
          get "/quby/questionnaires/honos/answers/#{answer.id}/edit", token: answer.token,
                                                                      hmac: hmac, timestamp: "fake"
        end.to raise_error(AnswersController::TimestampValidationError)
      end

      it 'redirects to roqua if the timestamp is expired' do
        get "/quby/questionnaires/honos/answers/#{answer.id}/edit",
            token: answer.token,
            hmac: hmac,
            timestamp: 1.day.ago.strftime("%Y-%m-%dT%H:%M:%S+00:00"),
            return_token: 'asdf',
            return_url: "/evaluate/collect_answers"
        expect(response).to redirect_to("/evaluate/collect_answers?expired_session=true" +
                                        "&key=asdf&return_from=quby&return_from_answer=#{answer.id}")
      end
    end
  end
end

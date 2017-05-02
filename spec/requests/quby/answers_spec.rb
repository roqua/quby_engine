# -*- coding: utf-8 -*-
require 'spec_helper'

module Quby
  describe AnswersController do
    def create_answer(questionnaire)
      Quby.questionnaires
        .stub(:find)
        .with(questionnaire.key)
        .and_return(questionnaire)

      Quby.answers.create!(questionnaire.key)
    end

    describe '#update' do
      before do
        Quby::Settings.stub(authorize_with_id_from_session: false)
        Quby::Settings.stub(authorize_with_hmac: false)
      end

      it 'saves the answer' do
        honos  = Quby::Questionnaires::DSL.build("honos", "question(:v1, type: :string)")
        answer = create_answer(honos)
        put "/quby/questionnaires/honos/answers/#{answer.id}", params: {answer: {v_1: nil}}

        response.should render_template(:completed)
      end

      it 'does not save invalid answers' do
        honos  = Quby::Questionnaires::DSL.build("honos", "question(:v1, type: :string, required: true)")
        answer = create_answer(honos)
        put "/quby/questionnaires/honos/answers/#{answer.id}", params: {answer: {v_1: nil}}

        response.should render_template('v1/paged')
        flash[:notice].should match(/nog niet volledig ingevuld/)
      end

      context 'upon successful save' do
        let(:honos)        { Quby::Questionnaires::DSL.build("honos", "question(:v1, type: :string)") }
        let(:answer)       { create_answer(honos) }
        let(:return_token) { 'abcd' }
        let(:return_url)   { "http://example.org" }

        def expected_return_url(options = {})
          Addressable::URI.parse(return_url).tap do |uri|
            uri.query_values = {key: return_token,
                                return_from: 'quby',
                                return_from_answer: answer.id,
                                status: 'updated',
                                go: 'next'}.merge(options)
          end.to_s
        end

        it 'renders print view if printing' do
          put "/quby/questionnaires/honos/answers/#{answer.id}/print", params: {answer: {v_1: nil}}
          response.should render_template('v1/print')
        end

        it 'renders completed view if no return url' do
          put "/quby/questionnaires/honos/answers/#{answer.id}", params: {answer: {v_1: nil}}
          response.should render_template('v1/completed')
        end

        it 'redirects to roqua if return url is set' do
          put "/quby/questionnaires/honos/answers/#{answer.id}", params: {
            answer: {v_1: nil},
            return_url: return_url,
            return_token: return_token
          }

          response.should redirect_to(expected_return_url)
        end

        it 'respects existing query parameters in return url' do
          put "/quby/questionnaires/honos/answers/#{answer.id}", params: {
            answer: {v_1: nil},
            return_url: return_url + "?a=b",
            return_token: return_token
          }

          response.should redirect_to(expected_return_url(a: 'b'))
        end

        it 'redirects with go of "close" if abort button was clicked' do
          put "/quby/questionnaires/honos/answers/#{answer.id}", params: {
            answer: {v_1: nil},
            return_url: return_url,
            return_token: return_token,
            abort: true
          }

          response.should redirect_to(expected_return_url(go: 'stop'))
        end

        it 'redirects with go of "back" when a user navigates back' do
          put "/quby/questionnaires/honos/answers/#{answer.id}", params: {
            answer: {v_1: nil},
            return_url: return_url,
            return_token: return_token,
            previous_questionnaire: true
          }

          response.should redirect_to(expected_return_url(go: 'back'))
        end
      end
    end
  end
end

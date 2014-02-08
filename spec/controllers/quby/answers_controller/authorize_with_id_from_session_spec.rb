require 'spec_helper'

module Quby
  describe AnswersController do
    include EngineControllerTesting

    let(:answer)        { double("Answer", id: '1') }
    let(:answers)       { double("Answers", find: answer) }
    let(:questionnaire) { double("Questionnaire", answers: answers, errors: []) }

    before do
      Quby::Settings.stub(authorize_with_hmac: false)
      Quby.questionnaire_finder.stub(find: questionnaire)
    end

    it 'allows requests when they match session and url answer id' do
      session[:quby_answer_id] = '1'
      get :edit, questionnaire_id: 'honos', id: '1'
      expect(response).to render_template(:edit)
    end

    it 'disallows requests when they dont match with session' do
      session[:quby_answer_id] = '2'
      get :edit, questionnaire_id: 'honos', id: '1', return_url: '/returnurl', return_token: 'asdf'
      expect(response).to redirect_to('/returnurl?key=asdf&return_from=quby' \
                                      '&return_from_answer=1&status=authorization_error')
    end

    it 'disallows requests when they have no session' do
      get :edit, questionnaire_id: 'honos', id: '1', return_url: '/returnurl', return_token: 'asdf'
      expect(response).to redirect_to('/returnurl?key=asdf&return_from=quby' \
                                      '&return_from_answer=1&status=authorization_error')
    end
  end
end
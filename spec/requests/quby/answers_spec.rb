require 'spec_helper'

module Quby
  describe AnswersController do
    describe 'Facebook spider does not report' do
      it 'does not report' do
        finder = stub(:find => Questionnaire.new("honos"))
        Quby::Questionnaire.stub(questionnaire_finder: finder)
        Quby::Answer.stub(questionnaire_finder: finder)

        answer = Quby::Answer.create(:questionnaire_key => "honos")
        token  = answer.token
        timestamp = Time.now.strftime("%Y-%m-%dT%H:%M:%S 00:00")
        plain_hmac = [Quby::Settings.shared_secret, token, timestamp].join('|')
        hmac = Digest::SHA1.hexdigest(plain_hmac)

        expect do
          get "/quby/questionnaires/honos/answers/#{answer.id}/edit", token: answer.token, hmac: hmac, timestamp: timestamp.gsub(" ", "EB_PLUS")
        end.not_to raise_error
      end
    end

    def create_answer(questionnaire)
      Quby::Questionnaire.questionnaire_finder
        .stub(:find)
        .with(questionnaire.key)
        .and_return(questionnaire)

      Quby::Answer.questionnaire_finder
        .stub(:find)
        .with(questionnaire.key)
        .and_return(questionnaire)

      Quby::Answer.create(:questionnaire_key => questionnaire.key)
    end

    describe '#update' do
      before do
        AnswersController.any_instance.stub(:verify_hmac => true)
        AnswersController.any_instance.stub(:verify_token => true)
      end

      it 'saves the answer' do
        honos  = Questionnaire.new("honos", "question(:v1, type: :string)")
        answer = create_answer(honos)
        put "/quby/questionnaires/honos/answers/#{answer.id}", answer: {v_1: nil}

        response.should render_template(:completed)
      end

      it 'does not save invalid answers' do
        honos  = Questionnaire.new("honos", "question(:v1, type: :string, required: true)")
        answer = create_answer(honos)
        put "/quby/questionnaires/honos/answers/#{answer.id}", answer: {v_1: nil}

        response.should render_template(:edit)
        flash[:notice].should match(/nog niet volledig ingevuld/)
      end
    end
  end
end
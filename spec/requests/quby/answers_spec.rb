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

    # Questionnaire.all.each do |questionnaire|
      # describe "GET /questionnaires/#{questionnaire.key}/answers/some_id" do
        #before(:each) do
          #@answer = Answer.create!(:test => true,
                                  #:value => questionnaire.default_answer_value,
                                  #:questionnaire_id => questionnaire.id)
          #@timestamp = Time.now.getgm.strftime("%Y-%m-%dT%H:%M:%S+00:00")
          #@plain_hmac = [::Settings.shared_secret, @answer.token, @timestamp].join('|')
          #@hmac = Digest::SHA1.hexdigest(@plain_hmac)
        #end

        #it "should return HTTP 200 in paged mode" do
          #path = edit_questionnaire_answer_path(questionnaire, @answer,
                                              #:token => @answer.token,
                                              #:display_mode => 'paged',
                                              #:timestamp => @timestamp,
                                              #:hmac => @hmac)
          #get path
          #response.status.should be(200)
        #end

        #it "should return HTTP 200 in bulk mode" do
          #path = edit_questionnaire_answer_path(questionnaire, @answer,
                                              #:token => @answer.token,
                                              #:display_mode => 'bulk',
                                              #:timestamp => @timestamp,
                                              #:hmac => @hmac)
          #get path
          #response.status.should be(200)
        #end
      # end
    # end
  end
end
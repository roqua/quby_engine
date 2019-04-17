# frozen_string_literal: true

require 'spec_helper'

module Quby
  describe AnswersController do
    include EngineControllerTesting

    # let(:answer)        { Answer.new(id: 1) }
    # let(:questionnaire) { double("Questionnaire", key: 'honos', renderer_version: :v1, errors: []) }

    let(:questionnaire) { inject_questionnaire("test", <<-END) }
      question :v_1, type: :radio, required: false do
        title "Choose"
        option :a1, value: 1, description: "Ja"
        option :a2, value: 2, description: "Nee"
      end
    END

    let(:answer) { create_new_answer_for(questionnaire, 'v_1' => 'a2') }

    before do
      Quby::Settings.stub(authorize_with_hmac: false)
      Quby::Settings.stub(authorize_with_id_from_session: false)
    end

    describe '#pdf' do
      let(:questionnaire) { inject_questionnaire("test", <<-END) }
        question :v_1, type: :radio, required: true do
          title "Choose"
          option :a1, value: 1, description: "Ja"
          option :a2, value: 2, description: "Nee"
        end
      END

      let(:answer) { create_new_answer_for(questionnaire) }

      before do
        allow(Quby::PdfRenderer).to receive(:render_pdf).and_return("Very nice PDF")
      end

      context 'with fully answered questionnaire' do
        it 'renders and sends a pdf file' do
          put :pdf, questionnaire_id: questionnaire.key, id: answer.id, answer: {'v_1' => 'a2'}
          expect(response.header['Content-Type']).to eq('application/pdf')
        end
      end

      context 'with missing required answers' do
        it 'renders the questionnaire again' do
          allow_server_side_validation_error(always: true)
          put :pdf, questionnaire_id: questionnaire.key, id: answer.id, answer: {}
          expect(response.header['Content-Type']).to eq('text/html; charset=utf-8')
        end
      end
    end

    describe '#bad_questionnaire' do
      before do
        controller.stub(:find_questionnaire).and_raise(Quby::Questionnaires::Repos::QuestionnaireNotFound,
                                                       questionnaire.key)
      end

      it 'redirects to return_url when available' do
        put :edit, return_url: 'blah', questionnaire_id: questionnaire.key, id: answer.id

        expected = "\
blah?error=Quby%3A%3AQuestionnaires%3A%3ARepos%3A%3A\
QuestionnaireNotFound&key&return_from=quby&return_from_answer=#{answer.id}&status=error"

        expect(response).to redirect_to(expected)
      end

      it 'renders questionnaire_not_found if return_url is unavailable' do
        put :edit, questionnaire_id: questionnaire.key, id: answer.id
        expect(response).to render_template('quby/errors/questionnaire_not_found')
      end
    end
  end
end

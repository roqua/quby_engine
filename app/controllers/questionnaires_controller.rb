class QuestionnairesController < ApplicationController
  respond_to :html, :json, :xml

  def index
    @questionnaires = Questionnaire.active.all
    respond_with @questionnaires
  end

  def show
    @questionnaire = Questionnaire.find(params[:id])
    respond_with @questionnaire
  end
end

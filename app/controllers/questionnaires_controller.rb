class QuestionnairesController < ApplicationController
  respond_to :html, :json, :xml

  def index
    @questionnaires = Questionnaire.active.all
    respond_with @questionnaires
  end

  def show
    @questionnaire = Questionnaire.find_by_key(params[:id])
    respond_with @questionnaire
  end
end

class QuestionnairesController < ApplicationController
  respond_to :html, :json, :xml

  before_filter :ip_check_for_api_methods

  def index
    @questionnaires = Questionnaire.active.all
    respond_with @questionnaires
  end

  def show
    @questionnaire = Questionnaire.find_by_key(params[:id])
    respond_with @questionnaire
  end
end

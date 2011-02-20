class QuestionnairesController < ApplicationController
  respond_to :html, :json, :xml

  before_filter :ip_check_for_api_methods

  def index
    @questionnaires = Questionnaire.active.all
    respond_with @questionnaires
  end

  def show
    return head(Questionnaire.exists?(:key => params[:id]) ? 200 : 404) if request.head?
    @questionnaire = Questionnaire.find_by_key(params[:id])
    if @questionnaire
      respond_with @questionnaire
    else
      head 404
    end
  end
end

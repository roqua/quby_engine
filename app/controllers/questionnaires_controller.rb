class QuestionnairesController < ApplicationController
  respond_to :html, :json, :xml, :txt

  before_filter :ip_check_for_api_methods

  def index
    @questionnaires = Questionnaire.active.all
    respond_with @questionnaires
  end

  def show
    return head(Questionnaire.exists?(:key => params[:id]) ? 200 : 404) if request.head?
    @questionnaire = Questionnaire.find_by_key(params[:id])
    unless params[:extra_vars].blank?
      @extra_vars = params[:extra_vars].to_a.sort_by{|i| i[0].to_i}.map{|i| i[1]} rescue nil
    else
      @extra_vars = []
    end
    @roqua_key = params[:roqua_key]
    if @questionnaire
      respond_with @questionnaire
    else
      head 404
    end
  end
end

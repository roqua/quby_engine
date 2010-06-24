class QuestionnairesController < ApplicationController
  def index
    @questionnaires = Questionnaire.active.all

    respond_to do |format|
      format.json { render :json => @questionnaires }
      format.xml  { render :xml  => @questionnaires }
    end
  end

  def show
    @questionnaire = Questionnaire.find(params[:id])

    respond_to do |format|
      format.json { render :json => @questionnaire }
    end
  end
end

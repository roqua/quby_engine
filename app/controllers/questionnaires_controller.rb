class QuestionnairesController < ApplicationController
  def index
    @questionnaires = Questionnaire.all

    respond_to do |format|
      format.json { render :json => @questionnaires }
    end
  end

  def show
    @questionnaire = Questionnaire.find_by_key(params[:id])

    respond_to do |format|
      format.json { render :json => @questionnaire }
    end
  end
end

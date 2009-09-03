require File.join(RAILS_ROOT, "app", "questionnaires", "honosca")

@@questionnaires = { :honosca => Honosca }

class QuestionnairesController < ApplicationController

  def index
    @questionnaires = @@questionnaires.values
  end

  def show
    @questionnaire = Questionnaire.find(params[:id])
  end

  def edit
    @questionnaire = Questionnaire.find(params[:id])
  end

  def create
    @questionnaire = @@questionnaires[params[:id].to_sym]
    @questionnaire.save
  end

  def update
    @questionnaire.update_attributes(params[:id], params[:questionnaire])
  end

  def delete
    @questionnaire.delete(params[:id])
  end

end

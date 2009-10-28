
class QuestionnairesController < ApplicationController

  def index
    @questionnaires = Questionnaire.all
  end

  def new
    @questionnaires = @@questionnaires.values
  end

  def show
    @questionnaire = Questionnaire.find(params[:id])
  end

  def edit
    @questionnaire = Questionnaire.find(params[:id])
  end

  def create
    key = params[:questionnaire][:key]
    @questionnaire = @@questionnaires[key.to_sym].new
    if @questionnaire.save
      redirect_to :action => :show, :id => @questionnaire.id
    end
  end

  def update
    @questionnaire.update_attributes(params[:id], params[:questionnaire])
  end

  def delete
    @questionnaire.delete(params[:id])
  end

end

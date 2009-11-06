class AnswersController < ApplicationController
  
  def index
    @answers = Questionnaire.all
  end

  def new
    @answers = @@questionnaires.values
  end

  def show
    @answer = Questionnaire.find(params[:id])
  end

  def edit
    @answer = Questionnaire.find(params[:id])
  end

  def create
    key = params[:questionnaire][:key]
    @answer = @@questionaires[key.to_sym].new
    if @answer.save
      redirect_to :action => :show, :id => @answer.id
    end
  end

  def update
    @answer = Questionnaire.find(params[:id])
    @answer.update_attributes(params[@answer.class.to_s.underscore])

    if @answer.save
      redirect_to questionnaire_path(@answer)
    end
  end

  def delete
    @answer.delete(params[:id])
  end

end

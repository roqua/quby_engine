class AnswersController < ApplicationController
  
  def index
    @answers ||= Questionnaire.find(params[:questionnaire_id]).answers if params[:questionnaire_id]
    @answers ||= Answer.all
  end
  
  def new
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    @answer = @questionnaire.answers.new
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def create
    @answer = Questionnaire.find_by_key(params[:questionnaire][:key])
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

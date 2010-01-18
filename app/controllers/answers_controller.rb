class AnswersController < ApplicationController

  before_filter :select_style, :only => [:new, :edit]
  
  def index
    @questionnaire = Questionnaire.find(params[:questionnaire_id], :include => :answers)
    @answers = @questionnaire.answers if params[:questionnaire_id]
  end
  
  def new
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    @answer = @questionnaire.answers.new
  end

  def show
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    @answer = @questionnaire.answers.find(params[:id])
  end

  def edit
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    @answer = @questionnaire.answers.find(params[:id])
  end

  def create
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    @answer = @questionnaire.answers.create
    
    if @answer.update_attributes(params[:answer])
      redirect_to :action => :show, :id => @answer.id
    end
  end

  def update
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    @answer = @questionnaire.answers.find(params[:id])
    @answer.update_attributes(params[@answer.class.to_s.underscore])

    if @answer.save
      redirect_to questionnaire_path(@answer)
    end
  end

  def delete
    @answer.delete(params[:id])
  end

  protected

  def select_style
    @style = "form_" + (params[:style] || "panels")
  end

end

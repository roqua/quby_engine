class AnswersController < ApplicationController
  before_filter :find_questionnaire, :only => [:show, :create, :update]

  def show
    @answer = @questionnaire.answers.find(params[:id])

    respond_to do |format|
      format.json { render :json => @answer }
    end
  end

  def create
    @answer = @questionnaire.answers.create()

    respond_to do |format|
      format.json { render :json => @answer}
    end
  end

  def update
    @answer = @questionnaire.answers.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.json { render :json => @answer }
      else
        format.json { render :json => @answer.errors.to_json }
      end
    end
  end

  protected

  def find_questionnaire
    @questionnaire = Questionnaire.find_by_key(params[:questionnaire_id])
    render :text => "Questionnaire not found", :status => 404 unless @questionnaire
  end 

end

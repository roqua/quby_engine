class AnswersController < ApplicationController
  before_filter :find_questionnaire, :only => [:show, :edit, :create, :update]
  append_before_filter :find_answer, :only => [:show, :edit, :update]
  before_filter :verify_token, :only => [:show, :edit, :update]
  before_filter :remember_token_in_session

  def show
    respond_to do |format|
      format.json { render :json => @answer }
    end
  end

  def edit
  end

  def create
    @answer = @questionnaire.answers.create(params[:answer])

    respond_to do |format|
      format.json { render :json => @answer}
    end
  end

  def update
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
    
    unless @questionnaire
      render :text => "Questionnaire not found", :status => 404
      return false
    end
  end

  def find_answer
    @answer = @questionnaire.answers.find(params[:id]) 
  end

  def verify_token
    return true if Rails.env.development?
    
    unless @answer.token == (params[:token] || session[:answer_token])
      render :text => "Invalid token, or no token given"
      return false
    end
  end

  def remember_token_in_session
    if params[:token]
      session[:answer_token] = params[:token]
    end
  end

end

class AnswersController < ApplicationController
  before_filter :find_questionnaire, :only => [:index, :show, :edit, :create, :update]
  append_before_filter :find_answer, :only => [:show, :edit, :update]
  before_filter :verify_token, :only => [:show, :edit, :update]
  before_filter :remember_token_in_session
  before_filter :remember_return_url_in_session

  respond_to :html, :json, :xml

  def index
    @answers = @questionnaire.answers.all
    respond_with @answers
  end

  def show
    respond_with @answer
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
        if @answer.completed? and session[:return_url]
          redirect_to session[:return_url]
        else
          format.html { render :action => :edit }
          format.json { render :json => @answer }
        end
      else
        format.html { render :action => :edit, :error => "Could not save record." }
        format.json { render :json => @answer.errors.to_json }
      end
    end
  end

  protected

  def find_questionnaire
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    
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

  def remember_return_url_in_session
    if params[:return_url]
      session[:return_url] = params[:return_url]
    end
  end

end

class AnswersController < ApplicationController
  before_filter :find_questionnaire, :only => [:index, :show, :edit, :create, :update]
  before_filter :find_patient
  append_before_filter :find_answer, :only => [:show, :edit, :update]
  before_filter :verify_token, :only => [:show, :edit, :update]
  before_filter :remember_token_in_session
  before_filter :remember_return_url_in_session
  before_filter :check_aborted, :only => [:create, :update]
  
  respond_to :html, :json, :xml

  def check_aborted
    if params[:commit] == "Onderbreken" and @questionnaire.abortable
      params[:answer][:aborted] = true
    end
  end

  def index
    # TODO !important Add some IP filter here
    @answers = if @patient_id and @questionnaire
                 Answer.where(:patient_id => @patient_id, :questionnaire_id => @questionnaire.id)
               elsif @questionnaire
                 @questionnaire.answers.all
               elsif @patient_id
                 Answer.where(:patient_id => @patient_id)
               else
                 Answer.all
               end
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
        if @answer.valid?
          if session[:return_url]
            # FIXME Find and use library for combining URLs
            redirect_to "#{session[:return_url]}&key=#{session[:return_token]}" and return
          else
            render :action => "completed" and return
          end
        else
          flash[:notice] = "De vragenlijst is nog niet volledig ingevuld." 
          format.html { render :action => :edit }
          format.json { render :json => @answer }
        end
      else
        flash[:error] = "Could not save record."
        format.html { render :action => :edit }
        format.json { render :json => @answer.errors.to_json }
      end
    end
  end

  protected

  def find_questionnaire
    if params[:questionnaire_id]
      @questionnaire = Questionnaire.find_by_key(params[:questionnaire_id])
      
      unless @questionnaire
        render :text => "Questionnaire not found", :status => 404
        return false
      end
    end
  end

  def find_patient
    if params[:patient_id]
      @patient_id = params[:patient_id]
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
      session[:return_token] = params[:return_token]
    end
  end

end

class Admin::QuestionnairesController < AdminAreaController
  
  after_filter :check_questionnaire_errors, :only => [:show, :edit, :create, :update]
  
  def index
    @questionnaires = Questionnaire.active.order('questionnaires.key')
  end

  def new
    @questionnaire = Questionnaire.new
  end

  def show
    @questionnaire = Questionnaire.find_by_key(params[:id])
  end

  def edit
    @questionnaire = Questionnaire.find_by_key(params[:id])
  end

  def create
    @questionnaire = Questionnaire.new
    @questionnaire.key = params[:questionnaire][:key]
    @questionnaire.definition = params[:questionnaire][:definition]
    @questionnaire.last_author = current_user.email
    
    if @questionnaire.save
      redirect_to edit_admin_questionnaire_path(@questionnaire)
    else
      render :action => :new
    end
  end

  def update
    @questionnaire = Questionnaire.find_by_key(params[:id])
    @questionnaire.definition = params[:questionnaire][:definition]
    @questionnaire.last_author = current_user.email
    
    if @questionnaire.save
      redirect_to edit_admin_questionnaire_path(@questionnaire)
    else
      render :action => :edit
    end
  end

  def delete
    @questionnaire.delete_by_key(params[:id])
  end

  def test
    @questionnaire = Questionnaire.find_by_key(params[:id])
    @answer = @questionnaire.answers.find_or_create_by_test(true)
    redirect_to edit_questionnaire_answer_path(@questionnaire, @answer, :token => @answer.token)
  end
  
  protected
  
  def check_questionnaire_errors
    if not @questionnaire.errors.empty?
      flash[:error] = "Could not save questionnaire, error in questionnaire definition"
    end
  end
  
end

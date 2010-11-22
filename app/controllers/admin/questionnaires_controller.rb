class Admin::QuestionnairesController < AdminAreaController
  
  def index
    @questionnaires = Questionnaire.active.all
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

    if @questionnaire.save
      redirect_to edit_admin_questionnaire_path(@questionnaire)
    else
      render :action => :new
    end
  end

  def update
    @questionnaire = Questionnaire.find_by_key(params[:id])
    @questionnaire.definition = params[:questionnaire][:definition]

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
    redirect_to edit_questionnaire_answer_path(@questionnaire, @answer)
  end
  
end

module Quby
  class Admin::AnswersController < AdminAreaController

    before_filter :select_style, :only => [:new, :edit]
    
    def index
      @questionnaire = Questionnaire.find_by_key(params[:questionnaire_id], :include => :answers)
      @answers = @questionnaire.answers if params[:questionnaire_id]
    end
    
    def new
      @questionnaire = Questionnaire.find_by_key(params[:questionnaire_id])
      @answer = @questionnaire.answers.new
    end

    def show
      @questionnaire = Questionnaire.find_by_key(params[:questionnaire_id])
      @answer = @questionnaire.answers.find(params[:id])
    end

    def edit
      @questionnaire = Questionnaire.find_by_key(params[:questionnaire_id])
      @answer = @questionnaire.answers.find(params[:id])
    end

    def create
      @questionnaire = Questionnaire.find_by_key(params[:questionnaire_id])
      @answer = @questionnaire.answers.create
      
      if @answer.update_attributes(params[:answer])
        redirect_to :action => :show, :id => @answer.id
      end
    end

    def update
      @questionnaire = Questionnaire.find_by_key(params[:questionnaire_id])
      @answer = @questionnaire.answers.find(params[:id])
      @answer.update_attributes(params[@answer.class.to_s.underscore])

      if @answer.save
        redirect_to admin_questionnaire_path(@answer)
      end
    end

    def destroy
      @questionnaire = Questionnaire.find_by_key(params[:questionnaire_id])
      @answer = @questionnaire.answers.find(params[:id])
      @answer.destroy
      redirect_to :action => :index
    end

    protected

    def select_style
      @style = "form_" + (params[:style] || "panels")
    end
  end
end

class AnswersController < ApplicationController
  def create
    @questionnaire = Questionnaire.find_by_key(params[:questionnaire_id])
    render :text => "Questionnaire not found", :status => 404 unless @questionnaire
    
    @answer = @questionnaire.answers.create()

    respond_to do |format|
      format.json { render :json => @answer}
    end
  end

  def update
    @questionnaire = Questionnaire.find_by_key(params[:questionnaire_id])
    render :text => "Questionnaire not found", :status => 404 unless @questionnaire

    @answer = @questionnaire.answers.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.json { render :json => @answer }
      else
        format.json { render :json => @answer.errors.to_json }
      end
    end
end

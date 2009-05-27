class QuestionnairesController < ApplicationController
  def take
    begin
      @questionnaire = params[:id].classify.constantize.new
    rescue NameError => e
      render :text => "That's not a valid questionnaire."
    end
  end

  def answer
    @questionnaire = params[:id].classify.constantize.new(params[:questionnaire])
    
    if @questionnaire.save
      redirect_to @questionnaire
    end
  end
end

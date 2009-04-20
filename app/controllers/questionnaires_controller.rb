class QuestionnairesController < ApplicationController
  def take
    @questionnaire = "Questionnaires::#{params[:id].classify}".constantize.new
  end

  def answer
    @questionnaire = "Questionnaires::#{params[:id].classify}".constantize.new
  end
end

require File.join(RAILS_ROOT, "app", "questionnaires", "honosca")

@@questionnaires = { :honosca => Honosca }

class QuestionnairesController < ApplicationController

  def index
    @questionnaires = @@questionnaires
  end

  def take
    @questionnaire = @@questionnaires[params[:id].to_sym].new
  end

  def answer
    @questionnaire = @@questionnaires[params[:id].to_sym].new(params[:questionnaire])
    
    if @questionnaire.save
      redirect_to @questionnaire
    end
  end
end

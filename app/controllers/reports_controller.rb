class ReportsController < ApplicationController
  def show
    q = Questionnaire.find(params[:questionnaire_id])
    @questionnaire = q['type'].constantize.find(q.id)
  end
end

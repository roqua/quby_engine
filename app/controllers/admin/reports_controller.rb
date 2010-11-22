class Admin::ReportsController < AdminAreaController
  def show
    q = Questionnaire.find_by_key(params[:questionnaire_id])
    @questionnaire = q['type'].constantize.find(q.id)
  end
end

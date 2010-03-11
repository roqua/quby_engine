class CodebooksController < ApplicationController
  def show
    @questionnaire = Questionnaire.find(params[:questionnaire_id])

    respond_to do |format|
      format.txt { render :type => "text/plain" }
    end
  end
end

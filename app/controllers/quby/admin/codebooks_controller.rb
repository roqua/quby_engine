module Quby
  class Admin::CodebooksController < AdminAreaController
    def show
      @questionnaire = Questionnaire.find_by_key(params[:questionnaire_id])

      respond_to do |format|
        format.txt { render :type => "text/plain" }
      end
    end
  end
end

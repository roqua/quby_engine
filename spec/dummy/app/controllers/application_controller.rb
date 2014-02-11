class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_answer_complete
    render text: 'answer_complete!'
  end
end

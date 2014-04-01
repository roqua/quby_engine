class TestsuiteController < ActionController::Base
  def after_answer_complete
    render text: 'answer_complete!'
  end
end

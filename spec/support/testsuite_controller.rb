# frozen_string_literal: true

class TestsuiteController < ActionController::Base
  def after_answer_complete
    render body: 'answer_complete!'
  end
end

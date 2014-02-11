class ApplicationController < ActionController::Base
  protect_from_forgery

  def foo
    render text: 'foo'
  end
end

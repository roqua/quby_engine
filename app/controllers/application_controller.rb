# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery
  layout 'application'

  before_filter :log_session_hash

  # TODO: Rails3
  # filter_parameter_logging :password
  #
  protected

  def log_session_hash
    logger.info "  Session: #{session.inspect}"
  end
end

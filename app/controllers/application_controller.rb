# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'ipaddr'
class ApplicationController < ActionController::Base
  # include CentralLogger::Filter

  helper :all # include all helpers, all the time
  protect_from_forgery
  layout :layout_by_resource

  before_filter :log_session_hash

  # TODO: Rails3
  # filter_parameter_logging :password

  protected

  def log_session_hash
    logger.info "  Session: #{session.inspect}"
  end

  def ip_check_for_api_methods
    # SECURITY CRITICAL : Checks whether this API method call is coming from one of our own servers
    return true if Rails.env.development?
    return true if Settings.api_allowed_ip_ranges.blank?

    if not Settings.api_allowed_ip_ranges.find { |range_or_addr| IPAddr.new(range_or_addr).include?(IPAddr.new(request.remote_ip)) }
      head(403)
    end
  end

  def layout_by_resource
    if devise_controller?
      "dialog"
    else
      "application"
    end
  end
end

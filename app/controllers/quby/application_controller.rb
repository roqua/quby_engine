require 'ipaddr'

module Quby
  class ApplicationController < ActionController::Base
    helper :all # include all helpers, all the time
    protect_from_forgery

    around_filter :log_session_hash
    before_filter :fix_ie_trusted_party_warning

    protected

    def prevent_browser_cache
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end

    def fix_ie_trusted_party_warning
      # Indicate IE that we are a trusted party
      response.headers["P3P"] = "CP=\"CAO PSA OUR\""
    end

    def log_session_hash
      logger.info "  User agent: #{request.headers['User-Agent']}"
      logger.info "  Session ID: #{request.session_options[:id]}"
      logger.info "  Process PID: #{Process.pid}" unless Rails.env.development?
      logger.info "  Pre-request session: #{session.inspect}"
      yield
      logger.info "  Post-request session: #{session.inspect}"
    end
  end
end

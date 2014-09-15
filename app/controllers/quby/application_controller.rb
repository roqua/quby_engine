require 'ipaddr'

module Quby
  class ApplicationController < ActionController::Base
    include Roqua::Support::RequestLogging if defined?(Roqua::Support::RequestLogging)

    helper :all # include all helpers, all the time
    protect_from_forgery

    around_filter :log_session_hash
    before_filter :prevent_browser_cache
    before_filter :enable_internet_explorer_cookies_inside_iframe
    before_filter :configure_x_frame_header

    protected

    def prevent_browser_cache
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end

    def enable_internet_explorer_cookies_inside_iframe
      # Internet Explorer needs this response header so that we can use cookies when
      # we're embedded in an <iframe>.
      #
      # The idea behind the P3P-header is that sites can state their intent:
      # the kinds of information they gather and what they plan to do with it.
      # This only applies to sites inside iframes, which could be genuine uses,
      # but might also be banner networks which the user might not want to allow.
      # The user, through the browser options, can then decide which intentions
      # are allowed.
      #   -- http://stackoverflow.com/a/389458
      #
      # CAO means we collect a whole bunch of information.
      # PSA means we use this to build a pseudonymous record, and don't store actual names
      # OUR means only we and the agencies for whom we are acting have access to this information.
      #   -- http://stackoverflow.com/a/5258105
      #
      # Obviously everyone could say they don't do malicious things with your data
      # which is why this header never gained much traction. The idea was that if a site
      # lies, they'll have troubles in court. In practice, the entire world simply
      # lies about their intent, and the header is basically worthless.
      #
      # A side-effect of cookies being disabled by by default is that it makes it hard
      # for a malicious site to embed a site and perform a clickjacking attack,
      # since without this header an embedded site will not have cookies, and
      # will thus never have the logged-in state.
      #
      # Since the primary use-case for RoQua is to be embedded in an EPD-window,
      # we need this header to be able to function at all.
      response.headers["P3P"] = "CP=\"CAO PSA OUR\""
    end

    def configure_x_frame_header
      # TODO: Better would be something like 'ALLOW-FROM http://localhost'
      # except we don't know yet which domains to whitelist.
      #
      # The Rails 4 default of SAMEORIGIN doesn't work for us, since we're
      # using several domains.
      headers.delete('X-Frame-Options')
    end

    def log_session_hash
      logger.info "  User agent: #{request.headers['User-Agent']}"
      logger.info "  Session ID: #{request.session_options[:id]}"
      logger.info "  Process PID: #{Process.pid}" unless Rails.env.development?
      logger.info  "  Pre-request session hash: #{session.to_json}"

      if respond_to?(:add_log_information)
        add_log_information :useragent,  request.headers['User-Agent']
        add_log_information :session_id, request.session_options[:id]
        add_log_information :session,    session
      end

      yield

      logger.info  "  Post-request session hash: #{session.to_json}"
    end

    def handle_exception(exception)
      logger.error("EXCEPTION: #{exception.message}")
      logger.error(exception.backtrace)

      if Rails.env.development? || Rails.env.test?
        logger.error "Exception reraised"
        fail exception
      elsif defined?(notify_airbrake)
        logger.error "Exception sent to Airbrake"
        notify_airbrake(exception)
      elsif defined?(ExceptionNotifier)
        logger.error "Exception sent to ExceptionNotifier"
        ExceptionNotifier::Notifier.exception_notification(request.env, exception).deliver
      end
    end
  end
end

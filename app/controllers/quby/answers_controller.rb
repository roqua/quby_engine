# -*- coding: utf-8 -*-
require 'addressable/uri'

module Quby
  class AnswersController < Quby::ApplicationController
    class Unauthorized < StandardError; end
    class TokenValidationError < Exception; end
    class TimestampValidationError < Exception; end
    class QuestionnaireNotFound < StandardError; end

    before_filter :find_questionnaire
    append_before_filter :find_answer

    before_filter :load_token_and_hmac_and_timestamp
    before_filter :load_return_url_and_token
    before_filter :load_custom_stylesheet
    before_filter :load_display_mode

    before_filter :authorize!
    before_filter :verify_token, only: [:show, :edit, :update, :print]
    before_filter :verify_hmac,  only: [:edit, :print]

    before_filter :prevent_browser_cache, only: :edit
    before_filter :check_aborted, only: :update

    protect_from_forgery except: [:edit, :update]

    rescue_from TokenValidationError,     with: :bad_token
    rescue_from QuestionnaireNotFound,    with: :bad_questionnaire
    rescue_from TimestampValidationError, with: :bad_timestamp
    rescue_from Unauthorized,             with: :bad_authorization

    def show
      redirect_to action: "edit"
    end

    def edit
      render action: "#{@display_mode}/edit"
    end

    def update(printing = false)
      updater = UpdatesAnswers.new(@answer)

      updater.on_success do
        render action: "print/show", layout: "layouts/content_only" and return if printing
        render action: "completed" and return if @return_url.blank?
        redirect_to_roqua(status: return_status) and return
      end

      updater.on_failure do
        flash.now[:notice] = "De vragenlijst is nog niet volledig ingevuld." if @display_mode != "bulk"
        if printing
          render action: "#{@display_mode}/edit", layout: "layouts/content_only"
        else
          render action: "#{@display_mode}/edit"
        end
      end

      updater.update(params[:answer])
    end

    def print
      update true
    end

    def bad_token(exception)
      @error = "Er is geen of een ongeldige token meegegeven."
      render file: "errors/generic", layout: "dialog"
      handle_exception exception unless exception.message =~ /Facebook/
    end

    def bad_questionnaire(exception)
      @error = "De opgegeven vragenlijst (#{params[:questionnaire_id]}) kon niet gevonden worden."
      render file: "errors/generic", layout: "dialog"
      handle_exception exception
    end

    def bad_timestamp(exception)
      @error = "Uw authenticatie is verlopen."
      render file: "errors/generic", layout: "dialog"
      handle_exception exception
    end

    def bad_authorization(exception)
      if @return_url
        redirect_to_roqua status: 'authorization_error', return_from_answer: params[:id]
      else
        @error = "U probeert een vragenlijst te openen waar u geen toegang toe heeft op dit moment."
        render file: 'errors/generic', layout: 'dialog'
        handle_exception exception
      end
    end

    def handle_exception(exception)
      logger.error("EXCEPTION: #{exception.message}")
      logger.error(exception.backtrace)

      if Rails.env.development? or Rails.env.test?
        logger.error "Exception reraised"
        raise exception
      elsif defined?(notify_airbrake)
        logger.error "Exception sent to Airbrake"
        notify_airbrake(exception)
      elsif defined?(ExceptionNotifier)
        logger.error "Exception sent to ExceptionNotifier"
        ExceptionNotifier::Notifier.exception_notification(request.env, exception).deliver
      end
    end

    protected

    def find_questionnaire
      if params[:questionnaire_id]
        @questionnaire = Quby.questionnaire_finder.find(params[:questionnaire_id])
        raise QuestionnaireNotFound unless @questionnaire
      end
    end

    def find_answer
      @answer = @questionnaire.answers.find(params[:id])
    end

    def check_aborted
      if (params[:commit] == "Onderbreken" and @questionnaire.abortable) or
        (params[:commit] == "Toch opslaan" and @display_mode == "bulk") or
        (params[:commit] == "← Vorige vragenlijst")
        params[:answer] ||= HashWithIndifferentAccess.new
        params[:answer][:aborted] = true
      else
        params[:answer] ||= HashWithIndifferentAccess.new
        params[:answer][:aborted] = false
      end
    end

    def authorize!
      if Quby::Settings.authorize_with_id_from_session
        raise Unauthorized unless params[:id] == session[:quby_answer_id]
      end
    end

    def verify_token
      if Quby::Settings.authorize_with_hmac
        unless @answer.token == (params[:token] || @answer_token)
          flash[:error] = I18n.t(:invalid_answer_get, locale: :nl)
          redirect_to "/"
        end
      end
    end

    def verify_hmac
      if Quby::Settings.authorize_with_hmac
        hmac      = (params['hmac']      || @hmac         || '').strip
        token     = (params['token']     || @answer_token || '').strip
        timestamp = (params['timestamp'] || @timestamp    || '').strip

        plain_hmac = [Quby::Settings.shared_secret, token, timestamp].join('|')
        our_hmac   = Digest::SHA1.hexdigest(plain_hmac)

        if timestamp =~ /EB_PLUS/
          logger.error "ERROR::Authentiocation error: Facebook Spider with malformed parameters"
          raise TokenValidationError, "Facebook Spider with EB_PLUS in timestamp"
        end

        if not timestamp =~ /^\d\d\d\d-?\d\d-?\d\d[tT ]?\d?\d:?\d\d/ or not time = Time.parse(timestamp)
          logger.error "ERROR::Authentication error: Invalid timestamp."
          raise TimestampValidationError
        end

        if time < 24.hours.ago or 1.hour.since < time
          logger.error "ERROR::Authentication error: Request expired"
          redirect_to_roqua(expired_session: "true") and return
        end

        if our_hmac != hmac
          logger.error "ERROR::Authentication error: Token does not validate"
          raise TokenValidationError, "HMAC"
        end
      end
    end

    def load_token_and_hmac_and_timestamp
      @answer_token = params[:token]     if params[:token]
      @hmac         = params[:hmac]      if params[:hmac]
      @timestamp    = params[:timestamp] if params[:timestamp]
    end

    def load_return_url_and_token
      if params[:return_url]
        @return_url   = CGI.unescape(params[:return_url])
        @return_token = params[:return_token]
      end
    end

    def load_display_mode
      if params[:display_mode] and %w(paged bulk).include?(params[:display_mode])
        @display_mode = params[:display_mode] if params[:display_mode]
      end

      @display_mode = "paged" if @display_mode.blank?
    end

    def load_custom_stylesheet
      @custom_stylesheet = params[:stylesheet]
    end

    def return_status
      case params[:commit]
      when "Onderbreken"
        "close"
      when "← Vorige vragenlijst"
        "back"
      else
        nil
      end
    end

    def redirect_to_roqua(options = {})
      address = Addressable::URI.parse(@return_url)

      # Addressable behaves strangely if were to do this directly on
      # it's own hash, hence the (otherwise unneeded) temporary variable
      query_values = (address.query_values || {})
      query_values.merge!(key: @return_token, return_from: "quby")
      query_values.merge!(return_from_answer: @answer.id)
      options.each { |key, value| query_values[key] = value if value }

      address.query_values = query_values

      logger.info address.to_s
      redirect_to address.to_s
    end

  end
end
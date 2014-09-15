# -*- coding: utf-8 -*-
require 'addressable/uri'

module Quby
  class AnswersController < Quby::ApplicationController
    class InvalidAuthorization < StandardError; end
    class MissingAuthorization < StandardError; end
    class TokenValidationError < Exception; end
    class TimestampValidationError < Exception; end
    class InvalidQuestionnaireDefinition < Exception; end

    before_filter :load_token_and_hmac_and_timestamp
    before_filter :load_return_url_and_token
    before_filter :load_custom_stylesheet
    before_filter :load_display_mode

    before_filter :authorize!
    before_filter :verify_hmac, only: [:edit, :print]

    before_filter :find_questionnaire
    before_filter :check_questionnaire_valid

    before_filter :find_answer
    before_filter :verify_token, only: [:show, :edit, :update, :print]

    before_filter :check_aborted, only: :update

    rescue_from TokenValidationError,                                           with: :bad_authorization
    rescue_from TimestampValidationError,                                       with: :bad_authorization
    rescue_from InvalidAuthorization,                                           with: :bad_authorization
    rescue_from MissingAuthorization,                                           with: :bad_authorization
    rescue_from Quby::Questionnaires::Repos::QuestionnaireNotFound,             with: :bad_questionnaire
    rescue_from InvalidQuestionnaireDefinition,                                 with: :bad_questionnaire_definition
    rescue_from Quby::Questionnaires::Entities::Questionnaire::ValidationError, with: :bad_questionnaire_definition

    def show
      redirect_to action: "edit"
    end

    def edit
      render_versioned_template @display_mode
    end

    def update(printing = false)
      updater = Answers::Services::UpdatesAnswers.new(@answer)

      updater.on_success do
        if printing
          render_versioned_template "print", layout: "content_only"
        elsif @return_url.blank?
          render_versioned_template "completed", layout: request.xhr? ? "content_only" : 'application'
        else
          redirect_url = return_url(status: 'updated', action: form_action)
          request.xhr? ?
            render(js: "window.location = '#{redirect_url}'") :
            redirect_to(redirect_url)
        end
      end

      updater.on_failure do
        flash.now[:notice] = "De vragenlijst is nog niet volledig ingevuld." if @display_mode != "bulk"
        if printing
          render_versioned_template @display_mode, layout: "content_only"
        else
          render_versioned_template @display_mode, layout: request.xhr? ? "content_only" : 'application'
        end
      end

      updater.update(params[:answer] || {})
    end

    def print
      update true
    end

    def bad_authorization(exception)
      if @return_url
        redirect_to return_url(status: 'error', error: exception.class.to_s)
      else
        @error = "U probeert een vragenlijst te openen waar u geen toegang toe heeft op dit moment."
        render template: 'quby/errors/generic', layout: 'quby/dialog'
        handle_exception exception
      end
    end

    def bad_questionnaire(exception)
      if @return_url
        redirect_to return_url(status: 'error', error: exception.class.to_s)
      else
        @error = exception
        render template: "quby/errors/questionnaire_not_found", layout: "quby/dialog", status: 404
      end
    end

    def bad_questionnaire_definition(exception)
      if Quby.show_exceptions
        render action: :show_questionnaire_errors
      elsif @return_url
        redirect_to return_url(status: 'error', error: exception.class.to_s)
        handle_exception exception
      else
        @error = "Er is iets mis met de vragenlijst zoals deze in ons systeem is ingebouwd."
        render template: 'quby/errors/generic', layout: 'quby/dialog'
        handle_exception exception
      end
    end

    protected

    def find_questionnaire
      if params[:questionnaire_id]
        @questionnaire = Quby.questionnaires.find(params[:questionnaire_id])
      end
    end

    def check_questionnaire_valid
      # don't use valid?, since it clears the errors
      return if @questionnaire.errors.size == 0
      fail InvalidQuestionnaireDefinition
    end

    def find_answer
      @answer = Quby.answers.find(@questionnaire.key, params[:id])
    end

    def check_aborted
      if (params[:commit] == "Onderbreken" && @questionnaire.abortable) ||
        (params[:commit] == "Toch opslaan" && @display_mode == "bulk") ||
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
        fail MissingAuthorization unless session[:quby_answer_id].present?
        fail InvalidAuthorization unless params[:id].to_s == session[:quby_answer_id].to_s
      end
    end

    def verify_token
      if Quby::Settings.authorize_with_hmac
        fail InvalidAuthorization unless @answer.token == (params[:token] || @answer_token)
      end
    end

    def verify_hmac # rubocop:disable CyclomaticComplexity
      if Quby::Settings.authorize_with_hmac
        fail TokenValidationError, "No HMAC secret is configured" unless Quby::Settings.shared_secret.present?
        hmac      = (params['hmac']      || @hmac         || '').strip
        token     = (params['token']     || @answer_token || '').strip
        timestamp = (params['timestamp'] || @timestamp    || '').strip

        current_hmac  = calculate_hmac(Quby::Settings.shared_secret, token, timestamp)

        if Quby::Settings.previous_shared_secret.present?
          previous_hmac = calculate_hmac(Quby::Settings.previous_shared_secret, token, timestamp)
        end

        if timestamp =~ /EB_PLUS/
          logger.error "ERROR::Authentiocation error: Facebook Spider with malformed parameters"
          fail TokenValidationError, "Facebook Spider with EB_PLUS in timestamp"
        end

        unless timestamp =~ /^\d\d\d\d-?\d\d-?\d\d[tT ]?\d?\d:?\d\d/ and time = Time.parse(timestamp)
          logger.error "ERROR::Authentication error: Invalid timestamp."
          fail TimestampValidationError
        end

        if time < 24.hours.ago or 1.hour.since < time
          logger.error "ERROR::Authentication error: Request expired"
          redirect_to return_url(expired_session: "true") and return
        end

        if current_hmac != hmac && (previous_hmac.blank? || previous_hmac != hmac)
          logger.error "ERROR::Authentication error: Token does not validate"
          fail TokenValidationError, "HMAC"
        end
      end
    end # rubocop:enable CyclomaticComplexity

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
      @display_mode = params[:display_mode] if %w(paged bulk).include? params[:display_mode]
      @display_mode ||= 'paged'
    end

    def load_custom_stylesheet
      @custom_stylesheet = params[:stylesheet]
    end

    def render_versioned_template(template_name, options = {})
      render template: "quby/#{@questionnaire.renderer_version}/#{template_name}",
             layout: "quby/#{@questionnaire.renderer_version}/layouts/#{options.fetch(:layout, "application")}"
    end

    def form_action
      case params[:commit]
      when "Onderbreken"
        "stop"
      when "← Vorige vragenlijst"
        "back"
      else
        'next'
      end
    end

    def return_url(options = {})
      address = Addressable::URI.parse(@return_url)

      # Addressable behaves strangely if were to do this directly on
      # it's own hash, hence the (otherwise unneeded) temporary variable
      query_values = (address.query_values || {})
      query_values.merge!(key: @return_token, return_from: "quby")
      query_values.merge!(return_from_answer: params[:id])
      options.each { |key, value| query_values[key] = value if value }

      address.query_values = query_values

      logger.info address.to_s
      address.to_s
    end

    def calculate_hmac(*args)
      Digest::SHA1.hexdigest(args.join('|'))
    end
  end
end

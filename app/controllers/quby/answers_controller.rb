# frozen_string_literal: true

# -*- coding: utf-8 -*-
require 'addressable/uri'
require 'browser'

module Quby
  class AnswersController < Quby::ApplicationController
    DISPLAY_MODES = %w(paged bulk single_page).freeze

    before_action :load_token_and_hmac_and_timestamp
    before_action :load_return_url_and_token
    before_action :load_custom_stylesheet
    before_action :load_display_mode

    before_action :verify_answer_id_against_session
    before_action :verify_hmac, only: [:edit, :pdf]

    before_action :find_questionnaire
    before_action :check_questionnaire_valid

    before_action :find_answer
    before_action :verify_token, only: [:show, :edit, :update]

    before_action :check_aborted, only: :update

    rescue_from TokenValidationError,                                           with: :bad_authorization
    rescue_from TimestampValidationError,                                       with: :bad_authorization
    rescue_from TimestampExpiredError,                                          with: :bad_authorization
    rescue_from InvalidAuthorizationError,                                      with: :bad_authorization
    rescue_from MissingAuthorizationError,                                      with: :bad_authorization
    rescue_from Quby::Questionnaires::Repos::QuestionnaireNotFound,             with: :bad_questionnaire
    rescue_from InvalidQuestionnaireDefinitionError,                            with: :bad_questionnaire_definition
    rescue_from Quby::Questionnaires::Entities::Questionnaire::ValidationError, with: :bad_questionnaire_definition

    def show
      redirect_to action: "edit"
    end

    def edit
      default_to_textvar_values(@answer)
      render versioned_template_options(@display_mode)
    end

    def update
      if session[:has_downloaded_pdf_for] == @answer.id && defined?(Appsignal) && on_ios_safari?
        Appsignal.increment_counter("ios_safari_downloaded_pdf_and_pressed_done", 1)
      end

      update_or_fail do
        if @return_url.blank?
          render versioned_template_options("completed", layout: request.xhr? ? "content_only" : 'application')
        else
          redirect_url = return_url(status: 'updated', go: form_action)
          request.xhr? ?
            render(js: "window.location = '#{redirect_url}'") :
            redirect_to(redirect_url)
        end
      end
    end

    def pdf
      if defined?(Appsignal) && on_ios_safari?
        session[:has_downloaded_pdf_for] = @answer.id
        Appsignal.increment_counter("ios_safari_downloaded_pdf", 1)
      end

      update_or_fail do
        template_string = render_to_string versioned_template_options("print", layout: "pdf")
        begin
          pdf_binary = Quby::PdfRenderer.render_pdf(template_string)
          # type is not a application/pdf, to prevent previews on ios
          send_data pdf_binary, filename: "#{@questionnaire.title} #{Time.zone.now.to_s(:filename)}.pdf",
                              type: 'application/octet-stream', disposition: :attachment
        rescue StandardError
          flash.now[:notice] = I18n.t('pdf_download_failed_message')
          render versioned_template_options(@display_mode, layout: request.xhr? ? "content_only" : 'application')
        end
      end
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

    def update_or_fail
      updater = Answers::Services::UpdatesAnswers.new(@answer)

      updater.on_success do
        yield
      end

      updater.on_failure do
        flash.now[:notice] = "De vragenlijst is nog niet volledig ingevuld." if @display_mode == "paged"
        render versioned_template_options(@display_mode, layout: request.xhr? ? "content_only" : 'application')
      end

      updater.update((params[:answer] || {}).merge("rendered_at" => params[:rendered_at]))
    end

    def find_questionnaire
      if params[:questionnaire_id]
        @questionnaire = Quby.questionnaires.find(params[:questionnaire_id])
      end
    end

    def check_questionnaire_valid
      # don't use valid?, since it clears the errors
      return if @questionnaire.errors.size == 0
      fail InvalidQuestionnaireDefinitionError
    end

    def find_answer
      @answer = Quby.answers.find(@questionnaire.key, params[:id])
    end

    def check_aborted
      if (params[:abort] && @questionnaire.abortable) ||
        (params[:save_anyway] && (@display_mode == "bulk" || @display_mode == "single_page")) ||
        (params[:previous_questionnaire])
        params[:answer] ||= HashWithIndifferentAccess.new
        params[:answer][:aborted] = true
      else
        params[:answer] ||= HashWithIndifferentAccess.new
        params[:answer][:aborted] = false
      end
    end

    def verify_answer_id_against_session
      if Quby::Settings.authorize_with_id_from_session
        fail MissingAuthorizationError unless session[:quby_answer_id].present?
        fail InvalidAuthorizationError unless params[:id].to_s == session[:quby_answer_id].to_s
      end
    end

    def verify_token
      if Quby::Settings.authorize_with_hmac
        fail InvalidAuthorizationError unless @answer.token == (params[:token] || @answer_token)
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

        unless timestamp =~ /^\d\d\d\d-?\d\d-?\d\d[tT ]?\d?\d:?\d\d/ and time = Time.parse(timestamp)
          logger.error "ERROR::Authentication error: Invalid timestamp."
          fail TimestampValidationError
        end

        if time < 24.hours.ago or 1.hour.since < time
          logger.error "ERROR::Authentication error: Request expired"
          fail TimestampExpiredError
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
      @display_mode = params[:display_mode] if DISPLAY_MODES.include? params[:display_mode]
      @display_mode ||= 'paged'
    end

    def load_custom_stylesheet
      @custom_stylesheet = params[:stylesheet]
    end

    def versioned_template_options(template_name, options = {})
      {template: "quby/#{@questionnaire.renderer_version}/#{template_name}",
       layout: "quby/#{@questionnaire.renderer_version}/layouts/#{options.fetch(:layout, "application")}"}
    end

    def form_action
      if params[:abort]
        'stop'
      elsif params[:previous_questionnaire]
        'back'
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

    def default_to_textvar_values(answer)
      @questionnaire.questions.each do |question|
        textvar = question.sets_textvar or next
        if answer.textvars.key?(textvar.to_sym) && !answer.value.key?(question.key.to_s)
          answer.value[question.key.to_s] ||= answer.textvars[textvar.to_sym]
        end
      end
    end

    # I18n.t based on the questionnaire's configuration.
    # This is done instead of configuring I18n.locale to allow for example
    # English questionnaires within a Dutch RoQua.
    def translate(key, options = {})
      I18n.t(key, options.merge(locale: @questionnaire.language))
    end
    helper_method :translate

    def on_ios_safari?
      browser = Browser.new(request.user_agent)
      browser.safari? && browser.platform.ios?
    end
  end
end

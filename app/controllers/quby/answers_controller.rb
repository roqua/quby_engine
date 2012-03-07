# -*- coding: utf-8 -*-
require 'addressable/uri'

module Quby
  class AnswersController < ApplicationController
    class TokenValidationError < Exception; end
    class TimestampValidationError < Exception; end
    class QuestionnaireNotFound < StandardError; end

    before_filter :find_questionnaire, :only => [:index, :show, :edit, :create, :update, :print]
    before_filter :find_patient
    append_before_filter :find_answer, :only => [:show, :edit, :update, :print]

    # SECURITY CRITICAL
    before_filter :ip_check_for_api_methods, :only => [:index, :create]

    before_filter :remember_token_in_session
    before_filter :remember_return_url_in_session
    before_filter :verify_token, :only => [:show, :edit, :update, :print]
    before_filter :verify_hmac, :only => [:edit, :print]

    before_filter :prevent_browser_cache, :only => :edit

    before_filter :remember_display_mode_in_session
    before_filter :check_aborted, :only => [:create, :update]

    protect_from_forgery :except => [:edit, :update], :secret => "6902d7823ec55aada227ae44423b939ef345e6e2acb9bb8e6203e1e8ce53d08dc461a0eaf8fa59cf68cd5d290d34fc1e7f2e7988aa6d414d5d88bfd8481868d9"

    respond_to :html, :json, :xml

    rescue_from TokenValidationError, :with => :bad_token
    rescue_from QuestionnaireNotFound, :with => :bad_questionnaire
    rescue_from TimestampValidationError, :with => :bad_questionnaire

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

    def index
      @answers = if @patient_id and @questionnaire
                  Answer.where(:patient_id => @patient_id, :questionnaire_key => @questionnaire.key)
                elsif @questionnaire
                  @questionnaire.answers.all
                elsif @patient_id
                  Answer.where(:patient_id => @patient_id)
                else
                  Answer.all
                end
      respond_with @answers
    end

    def show
      respond_to do |format|
        format.html { redirect_to :action => "edit" }
        format.json { render :json => @answer.to_json }
      end
    end

    def edit
      render :action => "#{@display_mode}/edit"
    end

    def create
      @answer = @questionnaire.answers.create({:questionnaire_key => @questionnaire.key, :value => @questionnaire.default_answer_value}.merge(params[:answer]||{}))
      logger.info "  Created answer #{@answer.id}"

      respond_to do |format|
        format.json { render :json => @answer.to_json }
      end
    end

    def update(printing=false)
      respond_to do |format|
        #Update_attributes also validates
        if @answer.update_attributes(params[:answer])
          if printing
            render :action => "print/show", :layout => "layouts/content_only" and return
          end
          case params[:commit]
          when "Onderbreken"
            @status = "close"
          when "← Vorige vragenlijst"
            @status = "back"
          end

          if @return_url.blank?
            render :action => "completed" and return 
          else
            if @status
              redirect_to_roqua(:params => {:status => @status}) and return
            else
              redirect_to_roqua and return
            end
          end
        else
          flash.now[:notice] = "De vragenlijst is nog niet volledig ingevuld." if @display_mode != "bulk"
          if printing
            format.html { render :action => "#{@display_mode}/edit", :layout => "layouts/content_only" }
          else 
            format.html { render :action => "#{@display_mode}/edit" }
          end
          format.json { render :json => @answer.errors.to_json }
        end
      end
    end

    def print
      update true
    end

    def bad_token(exception)
      @error = "Er is geen of een ongeldige token meegegeven."
      render :file => "errors/generic", :layout => "dialog"
      handle_exception exception
    end
    
    def bad_questionnaire(exception)
      @error = "De opgegeven vragenlijst (#{params[:questionnaire_id]}) kon niet gevonden worden."
      render :file => "errors/generic", :layout => "dialog"
      handle_exception exception
    end

    def bad_timestamp(exception)
      @error = "Uw authenticatie is verlopen."
      render :file => "errors/generic", :layout => "dialog"
      handle_exception exception
    end

    def handle_exception(exception)
      logger.error("EXCEPTION: #{exception.message}")
      logger.error(exception.backtrace)

      if Rails.env.development?
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
        @questionnaire = Quby::Questionnaire.find_by_key(params[:questionnaire_id])
        raise QuestionnaireNotFound unless @questionnaire
      end
    end

    def find_patient
      if params[:patient_id]
        @patient_id = params[:patient_id]
      end
    end

    def find_answer
      @answer = @questionnaire.answers.find(params[:id])
    end

    def verify_token
      unless (@answer.token == (params[:token] || @answer_token))
        flash[:error] = I18n.t(:invalid_answer_get, :locale => :nl)
        redirect_to "/" 
      end
    end

    def verify_hmac
      #return true if Rails.env.development?

      hmac      = (params['hmac']      || @hmac         || '').strip
      token     = (params['token']     || @answer_token || '').strip
      timestamp = (params['timestamp'] || @timestamp    || '').strip

      plain_hmac = [Quby::Settings.shared_secret, token, timestamp].join('|')
      our_hmac   = Digest::SHA1.hexdigest(plain_hmac)

      if our_hmac != hmac
        logger.error "ERROR::Authentication error: Token does not validate"
        raise TokenValidationError.new("HMAC") 
      end

      if not timestamp =~ /^\d\d\d\d-?\d\d-?\d\d[tT ]?\d?\d:?\d\d/ or not time = Time.parse(timestamp)
        logger.error "ERROR::Authentication error: Invalid timestamp."
        raise TimestampValidationError
      end

      if time < 24.hours.ago or 1.hour.since < time
        logger.error "ERROR::Authentication error: Request expired"
        redirect_to_roqua(:params => {:expired_session => "true"}) and return
      end
    end

    def remember_token_in_session
      @answer_token = params[:token]     if params[:token]
      @hmac         = params[:hmac]      if params[:hmac]
      @timestamp    = params[:timestamp] if params[:timestamp]
    end

    def remember_return_url_in_session
      if params[:return_url]
        @return_url   = CGI.unescape(params[:return_url])
        @return_token = params[:return_token]
      end
    end

    def remember_display_mode_in_session
      if params[:display_mode] and ["paged", "bulk"].include?(params[:display_mode])
        @display_mode = params[:display_mode] if params[:display_mode]
      end

      @display_mode = "paged" if @display_mode.blank?
    end

    def redirect_to_roqua(options = {})
      #FIXME: Flash proper error message when return_url is empty
      address = Addressable::URI.parse(@return_url)
      address.query_values = (address.query_values || {}).merge(:key => @return_token, :return_from => "quby")
      address.query_values = address.query_values.merge(options[:params]||{})
      logger.info address.to_s
      redirect_to address.to_s
    end

  end
end

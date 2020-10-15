require 'rails-i18n'
require_relative './quby/version'

module Quby
  autoload :ArrayAttributeValidValidator, 'active_model_modules/array_attribute_valid_validator'
  autoload :AttributeValidValidator, 'active_model_modules/attribute_valid_validator'
  autoload :TypeValidator, 'active_model_modules/type_validator'
  class BaseError < StandardError; end
  class InvalidAuthorizationError < BaseError; end
  class MissingAuthorizationError < BaseError; end
  class TokenValidationError < BaseError; end
  class TimestampValidationError < BaseError; end
  class TimestampExpiredError < BaseError; end
  class InvalidQuestionnaireDefinitionError < BaseError; end
  class ValidationError < BaseError; end
  class NoServerSideValidationInTestError < ArgumentError; end

  class << self
    # ==================================================================================================================
    #                     Quby configuration
    # ==================================================================================================================

    def show_exceptions
      @show_exceptions
    end

    def show_exceptions=(bool)
      @show_exceptions = bool
    end

    def answer_repo=(repo)
      @answer_repo = repo
      @answers_api = nil
    end

    def questionnaire_repo=(repo)
      @questionnaire_repo = repo
      @questionnaires_api = nil
    end

    def lookup_table_repo=(repo)
      @lookup_table_repo = repo
    end

    def lookup_table_repo
      @lookup_table_repo  || fail("Quby does not have its lookup table repo (Quby.lookup_table_repo) configured.")
    end

    def fixtures_path
      File.expand_path File.join('..', '..', 'spec', 'fixtures'), __FILE__
    end

    # ==================================================================================================================
    #                     Quby public API
    # ==================================================================================================================

    def answers
      @answers_api ||= Quby::Answers::API.new answer_repo: Quby.send(:answer_repo)
    end

    def questionnaires
      @questionnaires_api ||= Quby::Questionnaires::API.new questionnaire_repo: Quby.send(:questionnaire_repo)
    end

    # ==================================================================================================================
    #                     No more Quby public API, move along
    # ==================================================================================================================

    private

    def answer_repo
      @answer_repo || fail("Quby does not have its answer repo (Quby.answer_repo) configured.")
    end

    def questionnaire_repo
      @questionnaire_repo || fail("Quby does not have its questionnaire repo (Quby.questionnaire_repo) configured.")
    end
  end
end

require 'quby/settings'
require 'quby/compiler'
require 'quby/questionnaires'
require 'quby/answers'
require 'quby/engine'
require 'quby/lookup_table_repo'
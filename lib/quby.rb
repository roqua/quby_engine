require 'virtus'
require 'quby/extensions/maruku_extensions'
require 'quby/settings'
require 'quby/questionnaires'
require 'quby/questionnaires/repos/disk_repo'
require 'quby/answers'
require 'quby/answers/repos/memory_repo'
require "quby/engine"

module Quby
  class BaseError < StandardError; end
  class InvalidAuthorizationError < BaseError; end
  class MissingAuthorizationError < BaseError; end
  class TokenValidationError < BaseError; end
  class TimestampValidationError < BaseError; end
  class TimestampExpiredError < BaseError; end
  class InvalidQuestionnaireDefinitionError < BaseError; end

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

    def fixtures_path
      File.expand_path File.join('..', '..', 'spec', 'fixtures'), __FILE__
    end

    def lookup_table_path
      @lookup_table_path
    end

    def lookup_table_path=(new_path)
      @lookup_table_path = new_path
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

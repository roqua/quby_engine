require "monkey_patches/virtus"
require "quby/engine"

module Quby
  class << self
    # =======================================================
    #                     Quby configuration
    # =======================================================

    def questionnaires_path=(new_path)
      @questionnaires_path  = new_path
      @questionnaire_finder = nil
      @questionaires_api = nil
    end

    def show_exceptions=(bool)
      @show_exceptions = bool
    end

    def answer_repo=(repo)
      @answer_repo = repo
      @answers_api = nil
    end

    # =======================================================
    #                     Quby public API
    # =======================================================

    def answers
      @answers_api ||= Quby::Api::Answers.new answer_repo: Quby.send(:answer_repo)
    end

    def questionnaires
      @questionnaires_api ||= Quby::Api::Questionnaires.new questionnaire_repo: Quby.send(:questionnaire_finder)
    end

    private

    def answer_repo
      @answer_repo ||= Quby::AnswerRepos::MongoidRepo.new
    end

    def questionnaire_finder
      @questionnaire_finder ||= Quby::QuestionnaireRepos::DiskRepo.new(Quby.send :questionnaires_path)
    end

    def questionnaires_path
      @questionnaires_path
    end

    def show_exceptions
      @show_exceptions
    end
  end
end

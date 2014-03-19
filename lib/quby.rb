require "quby/engine"

module Quby
  class << self
    def questionnaires_path
      @questionnaires_path
    end

    def questionnaires_path=(new_path)
      @questionnaires_path  = new_path
      @questionnaire_finder = nil
    end

    def questionnaire_finder
      @questionnaire_finder ||= Quby::QuestionnaireFinder.new(Quby.questionnaires_path)
    end

    def show_exceptions
      @show_exceptions
    end

    def show_exceptions=(bool)
      @show_exceptions = bool
    end

    def answer_repo
      @answer_repo ||= Quby::AnswerRepos::MongoidRepo.new
    end
  end
end

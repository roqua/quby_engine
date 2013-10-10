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
  end
end

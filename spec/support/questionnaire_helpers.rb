# frozen_string_literal: true

def inject_questionnaire(key, definition)
  Quby.questionnaire_repo = Quby::Questionnaires::Repos::MemoryRepo.new(key => definition)
  Quby.questionnaires.find(key)
end

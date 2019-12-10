# frozen_string_literal: true

module Quby
  module Questionnaires
    module Repos
      autoload :Base, 'quby/questionnaires/repos/base'
      autoload :MemoryRepo, 'quby/questionnaires/repos/memory_repo'
      autoload :DiskRepo, 'quby/questionnaires/repos/disk_repo'

      QuestionnaireNotFound = Class.new(StandardError)
      DuplicateQuestionnaire = Class.new(StandardError)
    end
  end
end

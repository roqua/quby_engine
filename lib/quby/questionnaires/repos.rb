# frozen_string_literal: true

module Quby
  module Questionnaires
    module Repos
      QuestionnaireNotFound = Class.new(StandardError)
      DuplicateQuestionnaire = Class.new(StandardError)
    end
  end
end

require 'quby/questionnaires/repos/base'
require 'quby/questionnaires/repos/memory_repo'
require 'quby/questionnaires/repos/disk_repo'

# frozen_string_literal: true

module Quby
  module Answers
    module Repos
      autoload :Base, 'quby/answers/repos/base'
      autoload :MemoryRepo, 'quby/answers/repos/memory_repo'
      autoload :DiskRepo, 'quby/answers/repos/disk_repo'

      class AnswerNotFound < StandardError; end
    end
  end
end

module Quby
  module Answers
    module Repos
      AnswerNotFound = Class.new(StandardError)
    end
  end
end

require 'quby/answers/repos/base'
require 'quby/answers/repos/memory_repo'

require 'spec_helper'
require 'quby/api/specs/answers_api_specs'

module Quby
  module AnswerRepos
    describe MemoryRepo do
      before { Quby.answer_repo = Quby::AnswerRepos::MemoryRepo.new }

      it_behaves_like 'a valid backend for the answers api'
    end
  end
end

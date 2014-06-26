require 'spec_helper'

module Quby::Answers::Repos
  describe MemoryRepo do
    before { Quby.answer_repo = MemoryRepo.new }

    it_behaves_like 'a valid backend for the answers api'
  end
end

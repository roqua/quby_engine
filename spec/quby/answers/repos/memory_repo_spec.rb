require 'spec_helper'

module Quby::Answers::Repos
  describe MemoryRepo do
    it_behaves_like "an answer repository"

    context 'integrated with the public api' do
      before { Quby.answer_repo = MemoryRepo.new }
      it_behaves_like 'a valid backend for the answers api'
    end
  end
end

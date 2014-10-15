require 'spec_helper'

module Quby::Answers::Repos
  describe MemoryRepo do
    it_behaves_like "an answer repository"
    it_behaves_like 'a valid backend for the answers api'
  end
end

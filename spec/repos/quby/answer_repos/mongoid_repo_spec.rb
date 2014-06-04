require 'spec_helper'
require 'quby/answer_repos/specs'

module Quby
  module AnswerRepos
    describe MongoidRepo do
      it_behaves_like "an answer repository"
    end
  end
end

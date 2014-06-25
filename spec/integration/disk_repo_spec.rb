require 'spec_helper'
require 'quby/api/specs/questionnaires_api_specs'

module Quby
  module QuestionnaireRepos
    describe DiskRepo do
      before { Quby.questionnaires_path = Rails.root.join('..', '..', 'spec', 'fixtures') }

      it_behaves_like 'a valid backend for the questionnaires api'
    end
  end
end

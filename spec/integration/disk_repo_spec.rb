require 'spec_helper'

module Quby
  module Questionnaires
    module Repos
      describe DiskRepo do
        before { Quby.questionnaires_path = Rails.root.join('..', '..', 'spec', 'fixtures') }

        it_behaves_like 'a valid backend for the questionnaires api'
      end
    end
  end
end

require 'spec_helper'

module Quby::Questionnaires
  describe DSL do
    describe '.build_from_definition' do
      let(:repo) { Quby.send(:questionnaire_repo) }
      it 'builds a questionnaire from a definition' do
        definition = repo.find('simple')
        expect(described_class.build_from_definition(definition)).to be_instance_of(Entities::Questionnaire)
      end
    end
  end
end

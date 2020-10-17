require 'spec_helper'

module Quby::Questionnaires
  describe DSL do
    describe '.build_from_definition' do
      let(:repo) { Quby.send(:questionnaire_repo) }
      it 'builds a questionnaire from a definition' do
        definition = repo.find('simple')
        expect(described_class.build_from_definition(definition)).to be_instance_of(Entities::Questionnaire)
      end

      it 'uses a path on instance eval, so we get correct stack traces' do
        definition = Quby::Questionnaires::Entities::Definition.new(key: 'test',
                                                                    sourcecode: 'raise("problem")',
                                                                    path: 'spec/fixtures/raising.rb')
        expected_backtrace = include(end_with("spec/fixtures/raising.rb:1:in `block in build'"))
        expect { described_class.build_from_definition(definition) }.to \
          raise_exception(having_attributes(backtrace: expected_backtrace))
      end
    end
  end
end

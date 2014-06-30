if defined?(RSpec)
  RSpec.shared_examples "a questionnaire repository" do
    let(:repo) { described_class.new }

    describe 'record retrieval' do
      it 'finds all records'
      it 'finds records'
      it 'raises when record is not found'
    end
  end
end

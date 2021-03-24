# frozen_string_literal: true

if defined?(RSpec)
  RSpec.shared_examples 'a valid backend for the questionnaires api' do
    let(:api) { Quby::Questionnaires::API.new(questionnaire_repo: repo) }

    it 'supports finding a questionnaire' do
      expect(api.find('simple').key).to eq('simple')
    end

    it 'supports checking whether a questionnaire exists' do
      expect(api.exists? 'simple').to be_truthy
      expect(api.exists? 'inexistant_questionnaire').to be_falsey
    end

    it 'supports finding all questionnaires' do
      expect(api.all.map(&:key)).to include('simple')
      expect(api.all.map(&:key)).to include('simple_with_outcome')
    end
  end
end

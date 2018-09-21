# frozen_string_literal: true

if defined?(RSpec)
  RSpec.shared_examples 'a valid backend for the questionnaires api' do
    it 'supports finding a questionnaire' do
      expect(Quby.questionnaires.find('simple').key).to eq('simple')
    end

    it 'supports checking whether a questionnaire exists' do
      expect(Quby.questionnaires.exists? 'simple').to be_truthy
      expect(Quby.questionnaires.exists? 'inexistant_questionnaire').to be_falsey
    end

    it 'supports finding all questionnaires' do
      expect(Quby.questionnaires.all.map(&:key)).to include('simple')
      expect(Quby.questionnaires.all.map(&:key)).to include('simple_with_outcome')
    end
  end
end

require 'spec_helper'

module Quby::Questionnaires::Entities
  describe SubScoreSchema do
    let(:options) { {key: :totaal, export_key: :tot, label: 'Somscore'} }
    subject { SubScoreSchema.new options }

    it 'is valid' do
      expect(subject).to be_valid
    end
  end
end

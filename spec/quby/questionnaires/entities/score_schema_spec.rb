require 'spec_helper'

module Quby::Questionnaires::Entities
  describe ScoreSchema do
    let(:sub_options) { {key: :value, export_key: :tot, label: 'Somscore'} }
    let(:schema_options) { {key: :totaal, label: 'Totaalscore', sub_score_schemas: [sub_options]} }
    subject { ScoreSchema.new schema_options }

    it 'is valid' do
      expect(subject).to be_valid
    end

    it 'initializes sub score schemas from the provided hash' do
      expect(subject.sub_score_schemas.first).to be_a(SubScoreSchema)
    end

    describe '#export_key_labels' do
      it 'returns the score label associated with the given short key' do
        expect(subject.export_key_labels[:tot]).to eq('Somscore')
      end

      it 'searches with indifferent access' do
        expect(subject.export_key_labels['tot']).to eq('Somscore')
      end

      it 'returns nil if the score can not be found' do
        expect(subject.export_key_labels[:wah]).to eq(nil)
      end
    end

    describe 'when the scoreschema is invalid' do
      let(:schema_options) { {key: :value} }

      it 'sets helpful error messages' do
        subject.validate
        messages = subject.errors.full_messages
        expect(messages).to eq(["Label moet opgegeven zijn", "Sub score schemas moet opgegeven zijn"])
      end
    end

    describe 'when the subscoreschema is invalid' do
      let(:sub_options) { {key: :value} }
      it 'sets helpful error messages' do
        subject.validate
        expect(subject.errors.full_messages).to \
          eq(["Sub score schemas element #0 Label moet opgegeven zijn, Export key moet opgegeven zijn, \
Export key is not a symbol"])
      end
    end
  end
end

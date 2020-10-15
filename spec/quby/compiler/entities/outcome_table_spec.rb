require 'spec_helper'

module Quby::Compiler::Entities
  describe OutcomeTable do
    let(:questionnaire) do
      Quby::Compiler::DSL.build("test") do
        score(:key, label: 'score', schema: [{key: :value, label: 'Score', export_key: :key}]) { {value: 'oh1'} }
        score(:key2, label: 'score2', schema: [{key: :value, label: 'Score 2', export_key: :key2}]) { {value: 'oh2'} }
      end
    end
    describe '#references_existing_score_keys' do
      it 'adds errors if score_keys references scores not found in the questionnaire score schema' do
        table = described_class.new(key: :test_outcome_table,
                                    score_keys: %i[key unknown_key_1 unknown_key_2],
                                    subscore_keys: [:value],
                                    questionnaire: questionnaire)
        table.valid?
        expect(table.errors.full_messages).to eq(["Score keys :unknown_key_1 not found in score schemas",
                                                  "Score keys :unknown_key_2 not found in score schemas"])
      end

      it 'adds errors if subscore_keys references subscores not found in the questionnaire score schema' do
        table = described_class.new(key: :test_outcome_table,
                                    score_keys: [:key],
                                    subscore_keys: %i[unknown_key_1 unknown_key_2],
                                    questionnaire: questionnaire)
        table.valid?
        expect(table.errors.full_messages).to eq(["Subscore keys :unknown_key_1 not found in subscore schemas",
                                                  "Subscore keys :unknown_key_2 not found in subscore schemas"])
      end
    end
  end
end

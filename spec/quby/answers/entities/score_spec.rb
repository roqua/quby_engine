# frozen_string_literal: true

require 'spec_helper'

module Quby::Answers::Entities
  describe Score do
    let(:questionnaire) do
      Quby.questionnaires.find('score_test')
    end

    let(:answer) do
      # complicated way to get an answer
      answer = Quby.answers.create!('score_test')
      answer.value = {'v_1' => 'testvalue'}
      Quby.answers.update!(answer)
      Quby.answers.regenerate_outcome!(answer)
      Quby.answers.reload(answer)
    end

    subject do
      described_class.new score_schema: questionnaire.score_schemas.first.last,
                          score_hash: answer.scores.first.last
    end

    it 'exposes score schema fields' do
      expect(subject.key).to eq(:test)
      expect(subject.label).to eq('Testscore')
    end

    describe '#referenced_values' do
      it 'is exposed' do
        expect(subject.referenced_values).to eq(["v_1"])
      end
    end

    describe '#sub_scores' do
      let(:sub_score) {subject.sub_scores.first}
      it 'exposes subscore schema fields' do
        expect(sub_score.key).to eq(:value)
        expect(sub_score.export_key).to eq(:tes)
        expect(sub_score.label).to eq('Waarde')
      end

      it 'exposes subscore values' do
        expect(sub_score.value).to eq('testvalue')
        expect(subject.sub_scores.last.value).to eq('Matig')
      end
    end
  end
end

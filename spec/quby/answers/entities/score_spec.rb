# frozen_string_literal: true

require 'spec_helper'

module Quby::Answers::Entities
  describe Score do
    let!(:questionnaire) do
      inject_questionnaire "test", <<-END
          question :v_1, type: :string

          score :test, label: 'Testscore',
            schema: [{key: :value, export_key: :tes, label: 'Waarde'},
                     {key: :interpretation, export_key: :tes_i, label: 'Interpretatie'}] do
            {value: value(:v_1),
             interpretation: 'Matig'}
          end

          score :test2, label: 'Testscore 2',
            schema: [{key: :value, export_key: :tes2, label: 'Waarde'},
                     {key: :interpretation, export_key: :tes2_i, label: 'Interpretatie'}] do
            {value: 20,
             interpretation: 'Miniem'}
          end
      END
    end
    let(:answer) do
      # complicated way to get an answer
      answer = Quby.answers.create!('test')
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

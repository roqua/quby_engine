# frozen_string_literal: true

require 'spec_helper'

module Quby::Answers::Entities
  describe Score do
    let(:questionnaire) do
      Quby.questionnaires.find('score_test')
    end

    let(:v_1_value) { 10 }

    let(:answer) do
      # complicated way to get an answer
      answer = Quby.answers.create!('score_test')
      answer.value = {'v_1' => v_1_value}
      Quby.answers.update!(answer)
      Quby.answers.regenerate_outcome!(answer)
      Quby.answers.reload(answer)
    end

    subject { answer.score_objects.first }

    it 'exposes score schema fields' do
      expect(subject.key).to eq(:test)
      expect(subject.label).to eq('Testscore')
    end

    it 'exposes #referenced_values' do
      expect(subject.referenced_values).to eq(["v_1"])
    end

    describe '#subscores' do
      let(:subscore) { subject.subscores.first }
      it 'exposes subscore schema fields' do
        expect(subscore.key).to eq(:value)
        expect(subscore.export_key).to eq(:tes)
        expect(subscore.only_for_export).to eq(nil)
        expect(subscore.label).to eq('Waarde')
      end

      it 'exposes subscore values' do
        expect(subscore.value).to eq(10)
        expect(subject.subscores.last.value).to eq('Matig')
      end
    end

    describe 'when the score has missing values' do
      let(:v_1_value) { nil }
      it 'exposes nil as the value for each subscore, and leaves schema information alone' do
        expect(subject.subscores.last.value).to eq(nil)
        expect(subject.subscores.first.export_key).to eq(:tes)
        expect(subject.key).to eq(:test)
      end

      describe 'when the score has an exception' do
        # second score will error on nil
        subject { answer.score_objects.last }
        it 'exposes nil as the value for each subscore, and leaves schema information alone' do
          expect(subject.subscores.first.value).to eq(nil)
          expect(subject.subscores.first.export_key).to eq(:tes2)
          expect(subject.key).to eq(:test2)
        end

        it 'exposes the exception and backtrace under #error' do
          expect(subject.error).to match({exception: "undefined method `+' for nil:NilClass",
                                          backtrace: an_instance_of(Array)})
        end
      end
    end
  end
end

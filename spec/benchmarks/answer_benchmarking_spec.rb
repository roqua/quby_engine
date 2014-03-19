require 'spec_helper'
require 'benchmark'

module Quby
  describe "Benchmarks", benchmark: true do
    let(:questionnaire_finder) { QuestionnaireFinder.new(Rails.root.join("../../spec/fixtures")) }
    let(:questionnaire) { questionnaire_finder.find("big") }
    before { Answer.stub(questionnaire_finder: questionnaire_finder) }

    describe 'Questionnaire' do
      it 'should be quick to get a list of all questions' do
        n = 10_000

        # prepare cache
        questionnaire.questions

        Benchmark.bm(20) do |x|
          x.report("Questionnaire#questions")       { n.times { questionnaire.questions } }
        end
      end
    end

    describe "Answer" do
      it 'should be quick to validate' do
        n = 10_000
        answer = Answer.new(questionnaire_key: questionnaire.key)
        answer.save! # save so valid? does run update validations

        Benchmark.bm(20) do |x|
          x.report("Answer#valid?")       { n.times { answer.valid? } }
          x.report("Answer#completed?")   { n.times { answer.completed? } }
        end
      end
    end
  end
end

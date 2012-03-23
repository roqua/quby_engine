require 'spec_helper'
require 'benchmark'

module Quby
  describe "Benchmarks" do
    let(:questionnaire) { Questionnaire.find_by_key("panss") }

    describe 'Questionnaire' do
      it 'should be quick to get a list of all questions' do
        n = 10000
        
        # prepare cache
        questions = questionnaire.questions

        results = Benchmark.bm(20) do |x|
          x.report("Questionnaire#questions")       { n.times { questionnaire.questions } }
        end
      end
    end

    describe "Answer" do
      it 'should be quick to validate' do
        n = 10000
        answer = Answer.new(:questionnaire_key => questionnaire.key)
        answer.save! # save so valid? does run update validations
        #answer_validator = AnswerValidator.for(answer.questionnaire)

        results = Benchmark.bm(20) do |x|
          x.report("Answer#valid?")       { n.times { answer.valid? } }
          x.report("Answer#completed?")   { n.times { answer.completed? } }
          #x.report("AnswerValidator") { 10000.times { answer_validator.validate(answer) } }
        end
      end
    end
  end
end
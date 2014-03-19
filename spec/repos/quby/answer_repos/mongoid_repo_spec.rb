require 'spec_helper'

module Quby
  module AnswerRepos
    describe MongoidRepo do
      let(:repo) { MongoidRepo.new }

      it 'creates new records' do
        answer = repo.create!('big', value: {v_1: 'test'})
        answer.value.should eq("v_1" => 'test')
      end

      it 'finds records' do
        answer    = repo.create!('big', value: {v_1: 'test'})
        retrieved = repo.find('big', answer.id)
        retrieved.id.should eq(answer.id)
        retrieved.value.should eq('v_1' => 'test')
      end

      it 'updates records' do
        answer    = repo.create!('big', value: {v_1: 'test'})
        answer.value = {v_2: 'bar'}
        repo.update!(answer)

        retrieved = repo.find('big', answer.id)
        retrieved.value.should eq("v_2" => "bar")
      end

      it 'updates reorderings of scores' do
        answer = repo.create!('big', scores: {tot: {label: 'Totaalscore'},
                                              sub: {label: 'Subscore'}})
        answer.scores.keys.should eq %w(tot sub)
        repo.reload(answer).scores.keys.should eq %w(tot sub)

        answer.scores = {sub: {label: 'Subscore'}, tot: {label: 'Totaalscore'}}
        answer.scores.keys.should eq %w(sub tot)
        repo.update!(answer)
        repo.reload(answer).scores.keys.should eq %w(sub tot)
      end
    end
  end
end

require 'spec_helper'

feature 'Quby answers API' do
  let(:answer) { Quby.send(:answer_repo).create! 'mansa' }

  scenario 'find an answer' do
    expect(Quby.answers.find('mansa', answer.id).id).to eq(answer.id)
  end

  scenario 'reload an answer' do
    answer.value = {some: 'value'}
    expect(Quby.answers.reload(answer).value).to eq({})
  end

  scenario 'find all answers' do
    answer # make sure answer is persisted
    other_answer = Quby.send(:answer_repo).create! 'mansa'
    Quby.send(:answer_repo).create! 'big'
    expect(Quby.answers.all('mansa').map(&:id)).to eq([answer, other_answer].map(&:id))
  end

  scenario 'create an answer' do
    expect(Quby.answers.create!('mansa').id).to eq(Quby.send(:answer_repo).all('mansa').first.id)
  end
end

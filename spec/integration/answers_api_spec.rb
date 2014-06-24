require 'spec_helper'

feature 'Quby answers public API' do
  let(:answer)              { Quby.send(:answer_repo).create! 'simple' }
  let(:answer_with_outcome) { Quby.send(:answer_repo).create! 'simple_with_outcome' }

  scenario 'find an answer' do
    expect(Quby.answers.find('simple', answer.id).id).to eq(answer.id)
  end

  scenario 'reload an answer' do
    answer.value = {'v_1' => 0}
    expect(Quby.answers.reload(answer).value).to eq({})
  end

  scenario 'find all answers' do
    answer # make sure answer is persisted
    other_answer = Quby.send(:answer_repo).create! 'simple'
    answer_with_outcome # make sure answer_with_outcome is persisted
    expect(Quby.answers.all('simple').map(&:id)).to eq([answer, other_answer].map(&:id))
  end

  scenario 'find all answers completed after some date' do
    answer.completed_at = 3.days.ago
    Quby.send(:answer_repo).update! answer
    recent_answer = Quby.send(:answer_repo).create! 'simple', completed_at: 1.day.ago
    answer_ids = [answer, recent_answer].map(&:id)
    expect(Quby.answers.find_completed_after(2.days.ago, answer_ids).map(&:id)).to eq([recent_answer.id])
  end

  scenario 'create an answer' do
    expect(Quby.answers.create!('simple').id).to eq(Quby.send(:answer_repo).all('simple').first.id)
  end

  scenario 'update an answer' do
    answer.value = {'v_1' => 0}
    Quby.answers.update! answer
    expect(Quby.send(:answer_repo).reload(answer).value).to eq('v_1' => 0)
  end

  scenario 'generate outcome for an answer' do
    answer_with_outcome.value = {'v_1' => 2}
    expect(Quby.answers.generate_outcome(answer_with_outcome).scores).to eq(
      'simple_score' => {'value' => 2, 'referenced_values' => ['v_1'], 'score' => true, 'label' => 'SimpleScore'}
    )
    expect(Quby.send(:answer_repo).reload(answer_with_outcome).value).to eq({}) # does not presist the answer
  end

  scenario 'regenerating outcome for an answer' do
    answer_with_outcome.value = {'v_1' => 2}
    expect(Quby.answers.regenerate_outcome!(answer_with_outcome).scores).to eq(
      'simple_score' => {'value' => 2, 'referenced_values' => ['v_1'], 'score' => true, 'label' => 'SimpleScore'}
    )
    expect(Quby.send(:answer_repo).reload(answer_with_outcome).value).to eq('v_1' => 2) # persists the answer
  end
end

# frozen_string_literal: true

if defined?(RSpec)
  RSpec.shared_examples 'a valid backend for the answers api' do
    let(:repo) { described_class.new }
    let(:api)  { Quby::Answers::API.new(answer_repo: repo) }

    let(:answer)              { api.create! 'simple' }
    let(:answer_with_outcome) { api.create! 'simple_with_outcome' }

    it 'supports finding an answer' do
      expect(api.find('simple', answer.id).id).to eq(answer.id)
    end

    it 'supports reloading an answer' do
      answer.value = {'v_1' => 0}
      expect(api.reload(answer).value).to eq({})
    end

    it 'supports finding all answers' do
      answer # make sure answer is persisted
      other_answer = api.create! 'simple'
      answer_with_outcome # make sure answer_with_outcome is persisted
      expect(api.all('simple').map(&:id).sort).to eq([answer, other_answer].map(&:id).sort)
    end

    it 'supports finding all answers completed after some date' do
      answer.observation_time = 3.days.ago
      repo.update! answer
      recent_answer     = api.create! 'simple', observation_time: 1.day.ago
      incomplete_answer = api.create! 'simple'
      answer_ids = [answer, recent_answer, incomplete_answer].map(&:id).sort
      expect(api.find_completed_after(2.days.ago, answer_ids).map(&:id).sort).to eq([recent_answer.id])
    end

    it 'supports creating an answer' do
      expect(api.create!('simple').id).to eq(repo.all('simple').first.id)
    end

    it 'supports updating an answer' do
      answer.value = {'v_1' => 0}
      api.update! answer
      expect(repo.reload(answer).value).to eq('v_1' => 0)
    end

    it 'supports generating outcome for an answer' do
      answer_with_outcome.value = {'v_1' => 2}
      expect(api.generate_outcome(answer_with_outcome).scores).to eq(
        'simple_score' => {'value' => 2, 'referenced_values' => ['v_1'], 'score' => true, 'label' => 'SimpleScore'}
      )
      expect(repo.reload(answer_with_outcome).value).to eq({}) # does not presist the answer
    end

    it 'supports regenerating outcome for an answer' do
      allow(Quby).to receive(:answer_repo).and_return(repo)
      answer_with_outcome.value = {'v_1' => 2}
      api.regenerate_outcome!(answer_with_outcome)
      expect(answer_with_outcome.scores).to eq(
        'simple_score' => {'value' => 2, 'referenced_values' => ['v_1'], 'score' => true, 'label' => 'SimpleScore'}
      )
      expect(repo.reload(answer_with_outcome).value).to eq('v_1' => 2) # persists the answer
    end
  end
end

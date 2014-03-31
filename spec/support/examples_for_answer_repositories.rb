shared_examples "an answer repository" do
  let(:repo) { described_class.new }

  it 'creates new records' do
    require 'pry';binding.pry
    answer = repo.create!('big', value: {v_1: 'test'})
    answer.value.should eq("v_1" => 'test')
  end

  it 'finds records' do
    answer    = repo.create!('big', value: {v_1: 'test'})
    retrieved = repo.find('big', answer.id)
    retrieved.id.should eq(answer.id)
    retrieved.value.should eq('v_1' => 'test')
  end

  it 'finds records updated since some time' do
    answer1 = repo.create!('big')
    answer2 = repo.create!('big', completed_at: 4.days.ago)
    answer3 = repo.create!('big', completed_at: 1.days.ago)
    answer4 = repo.create!('big', completed_at: 1.days.ago)

    results = repo.find_completed_after(2.days.ago, [answer1.id, answer2.id, answer3.id]).to_a
    expect(results.map(&:id)).to eq([answer3.id])
    expect(results.map(&:id)).not_to include(answer4.id)
  end

  it 'raises when answer cannot be found' do
    expect { repo.find('big', 'unknown_id') }.to raise_exception(Quby::AnswerRepos::AnswerNotFound)
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

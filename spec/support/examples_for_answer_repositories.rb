shared_examples "an answer repository" do
  let(:repo) { described_class.new }

  let(:attributes) do
    {
      _id:                  'id-string',
      questionnaire_id:     123,
      questionnaire_key:    'quest-key-string',
      raw_params:           {v_1: 'test', v_2: :a1, some_else: 'other filtered out data'},
      value:                {v_1: 'test', v_2: :a1},
      patient:              {id: '123', gender: :male, birthyear: 1970},
      token:                SecureRandom.hex(8),
      active:               true,
      test:                 false,
      completed_at:         Time.local(2014, 1, 2, 3, 4, 5),
      outcome_generated_at: Time.local(2014, 1, 2, 3, 6, 7),
      scores:               {tot: {label: 'Totaalscore', value: 20}},
      actions:              {attention: [:v_1], alarm: []},
      completion:           {value: 1.0 / 3.0},
      import_notes:         {original_id: 'aabbcc', original_values: {'232' => 'a'}},
      dsl_last_update:      Time.local(2014, 1, 2, 3, 1, 1)
    }
  end

  describe 'record creation' do
    it 'creates new records' do
      answer = repo.create!('big', attributes)

      answer.id.should be_present
      verify(answer)
    end
  end

  describe 'record retrieval' do
    it 'finds records' do
      answer    = repo.create!('big', attributes)
      retrieved = repo.find('big', answer.id)

      retrieved.id.should eq(answer.id)
      verify(retrieved)
    end

    it 'raises when answer cannot be found' do
      expect { repo.find('big', 'unknown_id') }.to raise_exception(Quby::AnswerRepos::AnswerNotFound)
    end
  end

  describe 'record updating' do
    it 'updates records' do
      answer    = repo.create!('big', {})
      answer.raw_params           = attributes[:raw_params]
      answer.value                = attributes[:value]
      answer.patient              = attributes[:patient]
      answer.active               = attributes[:active]
      answer.test                 = attributes[:test]
      answer.completed_at         = attributes[:completed_at]
      answer.outcome_generated_at = attributes[:outcome_generated_at]
      answer.scores               = attributes[:scores]
      answer.actions              = attributes[:actions]
      answer.completion           = attributes[:completion]
      answer.import_notes         = attributes[:import_notes]
      answer.dsl_last_update      = attributes[:dsl_last_update]

      repo.update!(answer)

      retrieved = repo.find('big', answer.id)
      retrieved.id.should eq(answer.id)
      verify(retrieved)
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

  describe 'retrieving all records' do
    it 'finds records updated since some time' do
      answer1 = repo.create!('big')
      answer2 = repo.create!('big', completed_at: 4.days.ago)
      answer3 = repo.create!('big', completed_at: 1.days.ago)
      answer4 = repo.create!('big', completed_at: 1.days.ago)

      results = repo.find_completed_after(2.days.ago, [answer1.id, answer2.id, answer3.id]).to_a
      expect(results.map(&:id)).to eq([answer3.id])
      expect(results.map(&:id)).not_to include(answer4.id)
    end
  end

  def verify(record)
    record.questionnaire_key.should    eq('big')
    record.raw_params.should           eq(stringified(attributes[:raw_params]))
    record.value.should                eq(stringified(attributes[:value]))
    record.patient.should              eq(stringified(attributes[:patient]))
    record.active.should               be_true
    record.test.should                 be_false
    record.completed_at.should         eq(attributes[:completed_at])
    record.outcome_generated_at.should eq(attributes[:outcome_generated_at])
    record.scores.should               eq(stringified(attributes[:scores]))
    record.actions.should              eq(stringified(attributes[:actions]))
    record.completion.should           eq(stringified(attributes[:completion]))
    record.import_notes.should         eq(stringified(attributes[:import_notes]))
    record.dsl_last_update.should      be_present
  end

  def stringified(hash)
    result = {}
    hash.each do |key, value|
      case value
      when Hash
        result[key.to_s] = stringified(value)
      else
        result[key.to_s] = value
      end
    end
    result
  end

  it 'finds answers by given conditions' do
    repo.create!('big', scores: {tot: {label: 'Totaalscore'}, sub: {label: 'Subscore'}}, test: true)
    repo.create!('mansa', scores: {tot: {label: 'Totaalscore'}, sub: {label: 'Subscore'}}, test: false)
    expect(repo.where(test: true).length).to be 1
    expect(repo.where(test: true).first.questionnaire_key).to eq 'big'

    expect(repo.where(scores: {tot: {label: 'Totaalscore'}, sub: {label: 'Subscore'}}).length).to be 2
  end
end

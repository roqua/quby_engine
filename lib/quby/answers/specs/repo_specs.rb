if defined?(RSpec)
  RSpec.shared_examples "an answer repository" do
    let(:repo) { described_class.new }

    let(:attributes) do
      {
        _id:                   'id-string',
        questionnaire_id:      123,
        questionnaire_key:     'quest-key-string',
        raw_params:            {v_1: 'test', v_2: :a1, some_else: 'other filtered out data'},
        value:                 {v_1: 'test', v_2: :a1},
        patient:               {id: '123', gender: :male, birthyear: 1970},
        token:                 SecureRandom.hex(8),
        active:                true,
        test:                  false,
        started_completing_at: Time.local(2014, 1, 2, 3, 4, 0),
        completed_at:          Time.local(2014, 1, 2, 3, 4, 5),
        outcome_generated_at:  Time.local(2014, 1, 2, 3, 6, 7),
        scores:                {tot: {label: 'Totaalscore', value: 20}},
        actions:               {attention: [:v_1], alarm: []},
        completion:            {value: 1.0 / 3.0},
        import_notes:          {original_id: 'aabbcc', original_values: {'232' => 'a'}},
        dsl_last_update:       Time.local(2014, 1, 2, 3, 1, 1)
      }
    end

    describe 'record creation' do
      it 'creates new records' do
        answer = repo.create!('simple', attributes)

        expect(answer.id).to be_present
        verify(answer)
      end
    end

    describe 'record retrieval' do
      it 'finds all records for a given questionnaire' do
        answer1 = repo.create!('simple', attributes.merge(_id: 'answer1'))
        answer2 = repo.create!('simple', attributes.merge(_id: 'answer2'))

        answers = repo.all('simple')
        expect(answers.map(&:id)).to eq([answer1.id, answer2.id])

      end

      it 'finds records' do
        answer    = repo.create!('simple', attributes)
        retrieved = repo.find('simple', answer.id)

        expect(retrieved.id).to eq(answer.id)
        verify(retrieved)
      end

      it 'raises when answer cannot be found' do
        expect { repo.find('simple', 'unknown_id') }.to raise_exception(Quby::Answers::Repos::AnswerNotFound)
      end
    end

    describe 'record updating' do
      it 'updates records' do
        answer    = repo.create!('simple', {})
        answer.raw_params            = attributes[:raw_params]
        answer.value                 = attributes[:value]
        answer.patient               = attributes[:patient]
        answer.active                = attributes[:active]
        answer.test                  = attributes[:test]
        answer.started_completing_at = attributes[:started_completing_at]
        answer.completed_at          = attributes[:completed_at]
        answer.outcome_generated_at  = attributes[:outcome_generated_at]
        answer.scores                = attributes[:scores]
        answer.actions               = attributes[:actions]
        answer.completion            = attributes[:completion]
        answer.import_notes          = attributes[:import_notes]
        answer.dsl_last_update       = attributes[:dsl_last_update]

        repo.update!(answer)

        retrieved = repo.find('simple', answer.id)
        expect(retrieved.id).to eq(answer.id)
        verify(retrieved)
      end

      it 'updates reorderings of scores' do
        answer = repo.create!('simple', scores: {tot: {label: 'Totaalscore'},
                                                 sub: {label: 'Subscore'}})
        expect(answer.scores.keys).to eq %w(tot sub)
        expect(repo.reload(answer).scores.keys).to eq %w(tot sub)

        answer.scores = {sub: {label: 'Subscore'}, tot: {label: 'Totaalscore'}}
        expect(answer.scores.keys).to eq %w(sub tot)
        repo.update!(answer)
        expect(repo.reload(answer).scores.keys).to eq %w(sub tot)
      end
    end

    describe 'retrieving all records' do
      it 'finds records updated since some time' do
        answer1 = repo.create!('simple')
        answer2 = repo.create!('simple', completed_at: 4.days.ago)
        answer3 = repo.create!('simple', completed_at: 1.days.ago)
        answer4 = repo.create!('simple', completed_at: 1.days.ago)

        results = repo.find_completed_after(2.days.ago, [answer1.id, answer2.id, answer3.id]).to_a
        expect(results.map(&:id)).to eq([answer3.id])
        expect(results.map(&:id)).not_to include(answer4.id)
      end
    end

    def verify(record)
      expect(record.questionnaire_key).to     eq('simple')
      expect(record.raw_params).to            eq(stringified(attributes[:raw_params]))
      expect(record.value).to                 eq(stringified(attributes[:value]))
      expect(record.patient).to               eq(stringified(attributes[:patient]))
      expect(record.active).to                eq(true)
      expect(record.test).to                  eq(false)
      expect(record.started_completing_at).to eq(attributes[:started_completing_at])
      expect(record.completed_at).to          eq(attributes[:completed_at])
      expect(record.outcome_generated_at).to  eq(attributes[:outcome_generated_at])
      expect(record.scores).to                eq(stringified(attributes[:scores]))
      expect(record.actions).to               eq(stringified(attributes[:actions]))
      expect(record.completion).to            eq(stringified(attributes[:completion]))
      expect(record.import_notes).to          eq(stringified(attributes[:import_notes]))
      expect(record.dsl_last_update).to       be_present
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
  end
end

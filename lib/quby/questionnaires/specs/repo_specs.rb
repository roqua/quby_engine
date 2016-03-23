if defined?(RSpec)
  RSpec.shared_examples "a questionnaire repository" do
    describe '#all' do
      it 'finds all questionnaires' do
        repo.create!("test1", "title 'foo'")
        repo.create!("test2", "title 'bar'")
        expect(repo.all.map(&:key)).to eq %w(test1 test2)
      end
    end

    describe '#keys' do
      it 'returns the questionnaire keys' do
        repo.create!("test1", "title 'foo'")
        repo.create!("test2", "title 'bar'")
        expect(repo.keys).to eq %w(test1 test2)
      end
    end

    describe '#find' do
      it 'finds one questionnaire' do
        repo.create!('test', 'title "Foo"')

        retrieved = repo.find('test')
        expect(retrieved.key).to eq('test')
        expect(retrieved.sourcecode).to eq 'title "Foo"'
      end

      it 'raises when record is not found' do
        expect do
          repo.find('unknown_key')
        end.to raise_error(Quby::Questionnaires::Repos::QuestionnaireNotFound)
      end
    end

    describe '#exists?' do
      it 'returns true if questionnaire was added' do
        repo.create!("test", "")
        expect(repo.exists?("test")).to be_truthy
      end

      it 'returns false if questionnaire was not added' do
        expect(repo.exists?("unknown")).to be_falsey
      end
    end

    describe '#create!' do
      it 'stores questionnaire definitions' do
        repo.create!('test', 'title "Foo"')

        retrieved = repo.find('test')
        expect(retrieved.key).to eq('test')
        expect(retrieved.sourcecode).to eq 'title "Foo"'
      end

      it 'raises when key is already used' do
        repo.create!('test', 'title "Foo"')

        expect do
          repo.create!('test', 'title "Bar"')
        end.to raise_error(Quby::Questionnaires::Repos::DuplicateQuestionnaire)
      end
    end

    describe '#timestamp' do
      let(:time) { Time.at(Time.now.to_i) }# disregard milliseconds

      it 'returns the time a definition was stored' do
        Timecop.freeze(time) { repo.create! 'test', '' }
        expect(repo.timestamp('test')).to eq(time)
      end
    end
  end
end

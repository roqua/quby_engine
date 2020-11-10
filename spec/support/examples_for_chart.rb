# frozen_string_literal: true

shared_examples_for Quby::Questionnaires::Entities::Charting::Chart do
  it 'initializes with a key and options' do
    expect(described_class.new(key: :tot, title: "My Title")).to be
  end

  it 'coerces keys to be symbols' do
    expect(described_class.new(key: 'tot').key).to eq :tot
  end

  it 'has plottables' do
    score1 = {key: :tot}
    score2 = {key: :sub}
    expect(described_class.new(key: :tot, plottables: [score1, score2]).plottables[0].key).to eq(:tot)
    expect(described_class.new(key: :tot, plottables: [score1, score2]).plottables[1].key).to eq(:sub)
  end

  describe '#y_range' do
    it 'returns the y_range' do
      expect(described_class.new(key: 'chart', y_range: 100..200).y_range).to eq(100..200)
    end

    describe 'when y_categories is given and no y_range is given' do
      it 'returns 0..(y_categories.count - 1)' do
        expect(described_class.new(key: 'chart', y_categories: %w(Bad Great Best)).y_range).to eq(0..2)
      end
    end
  end

  it 'defaults y_range_categories to nil' do
    expect(described_class.new(key: 'test').y_range_categories).to eq(nil)
  end
end

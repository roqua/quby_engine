# frozen_string_literal: true

shared_examples_for Quby::Questionnaires::Entities::Charting::Chart do
  it 'initializes with a key and options' do
    expect(described_class.new(:tot, title: "My Title")).to be
  end

  it 'coerces keys to be symbols' do
    expect(described_class.new('tot').key).to eq :tot
  end

  it 'has plottables' do
    score1, score2 = double, double
    expect(described_class.new(:tot, plottables: [score1, score2]).plottables).to eq [score1, score2]
  end

  describe '#y_range' do
    it 'returns the y_range' do
      expect(described_class.new('chart', y_range: 100..200).y_range).to eq(100..200)
    end

    describe 'when y_categories is given and no y_range is given' do
      it 'returns 0..(y_categories.count - 1)' do
        expect(described_class.new('chart', y_categories: %w(Bad Great Best)).y_range).to eq(0..2)
      end
    end
  end

  it 'defaults y_range_categories to nil' do
    expect(described_class.new('test').y_range_categories).to eq(nil)
  end

  it 'can set plotlines' do
    chart = described_class.new(:tot, plotlines: [{value: 40, color: :red}])
    expect(chart.plotlines).to eq([{value: 40, color: :red}])
  end

  it 'can set plotbands' do
    chart = described_class.new(:tot, plotbands: [{from: 40, to: 60, color: :red}])
    expect(chart.plotbands).to eq([{from: 40, to: 60, color: :red}])
  end
end

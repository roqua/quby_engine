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
end

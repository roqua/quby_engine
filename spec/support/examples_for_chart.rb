shared_examples_for Quby::Charting::Chart do
  it 'initializes with a key and options' do
    described_class.new(:tot, title: "My Title").should be
  end

  it 'coerces keys to be symbols' do
    described_class.new('tot').key.should == :tot
  end

  it 'has scores' do
    score1, score2 = stub, stub
    described_class.new(:tot, scores: [score1, score2]).scores.should == [score1, score2]
  end
end

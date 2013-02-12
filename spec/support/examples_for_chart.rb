shared_examples_for Quby::Charting::Chart do
  it 'initializes with a key and options' do
    Quby::Charting::Chart.new(:tot, title: "My Title").should be
  end

  it 'coerces keys to be symbols' do
    Quby::Charting::Chart.new('tot').key.should == :tot
  end

  it 'has scores' do
    score1, score2 = stub, stub
    Quby::Charting::Chart.new(:tot, scores: [score1, score2]).scores.should == [score1, score2]
  end

end

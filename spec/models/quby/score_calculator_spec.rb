require_relative "../../../app/models/quby/score_calculator"

module Quby
  describe ScoreCalculator do
    describe '.calculate' do
      it 'calculates the value of a block' do
        score = stub
        calculator = ScoreCalculator.calculate { score }.should == score
      end
    end

    describe '#initialize' do
      it 'stores values passed' do
        calculator = ScoreCalculator.new(values: {'v_1' => 1})
        calculator.values.should == {'v_1' => 1}
      end
    end

    describe '#values' do
      let(:values) { {'v_1' => 1, 'v_2' => 4, 'v_3' => nil} }
      let(:calculator) { ScoreCalculator.new(values: values) }

      it 'returns the values hash if no args given' do
        calculator.values.should == values
      end

      it 'returns an array of values if args given' do
        calculator.values(:v_1, :v_2).should == [values['v_1'], values['v_2']]
      end

      it 'finds values by string' do
        calculator.values('v_1').should == [values['v_1']]
      end

      it 'raises if a value is requested which does not exist' do
        expect do
          calculator.values(:unknown_key)
        end.to raise_error(/unknown_key/)
      end
    end

    describe '#sum' do
      let(:calculator) { ScoreCalculator.new }

      it 'sums values given' do
        calculator.sum([1, 2, 3, 4]).should == 10
      end

      it 'sums no values' do
        calculator.sum([]).should == 0
      end
    end
  end
end
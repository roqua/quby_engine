require "spec_helper"

module Quby
  describe ScoreCalculator do

    let(:timestamp) { Time.now }

    describe '.calculate' do
      it 'calculates the value of a block' do
        score = stub
        calculator = ScoreCalculator.calculate({}, timestamp) { score }.should == score
      end
    end

    describe '#initialize' do
      it 'stores values passed' do
        calculator = ScoreCalculator.new({v_1: 1}, timestamp, {gender: :male}, {score1: 2})
        calculator.instance_variable_get("@values").should == {v_1: 1}
        calculator.instance_variable_get('@timestamp').should eq(timestamp)
        calculator.instance_variable_get("@patient").instance_variables
                  .should == ::Quby::Patient.new(gender: :male).instance_variables
        calculator.instance_variable_get("@scores").should == {score1: 2}.with_indifferent_access
      end
    end

    describe '#values' do
      let(:values) { {'v_1' => 1, 'v_2' => 4, 'v_3' => nil} }
      let(:scores) { {'score1' => 22} }
      let(:calculator) { ScoreCalculator.new(values, timestamp, {}, scores) }

      it 'returns the values hash if no args given' do
        calculator.values_with_nils.should == values
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

    describe '#values_with_nils' do
      let(:values) { {'v_1' => 1, 'v_2' => 4, 'v_3' => nil} }
      let(:scores) { {'score1' => 22} }
      let(:calculator) { ScoreCalculator.new(values, timestamp, {}, scores) }

      it 'returns the values hash if no args given' do
        calculator.values_with_nils.should == values
      end

      it 'returns an array of values if args given' do
        calculator.values_with_nils(:v_1, :v_2).should == [values['v_1'], values['v_2']]
      end

      it 'finds values by string' do
        calculator.values_with_nils('v_1').should == [values['v_1']]
      end

      it 'returns nil if a value is requested which is not available' do
        calculator.values_with_nils(:v_3).should  == [nil]
      end

      it 'raises if a value is requested more than once' do
        expect do
          calculator.values_with_nils(:v_1, 'v_1').should  == [nil]
        end.to raise_error(/requested more than once/)
      end
    end

    describe '#mean' do
      let(:calculator) { ScoreCalculator.new({}, timestamp) }

      it 'returns mean of values given' do
        calculator.mean([1, 2, 3, 4, 5]).should == 3
      end

      it 'returns a float value' do
        calculator.mean([2, 3]).should be_an_instance_of Float
      end

      it 'returns 0 for empty array' do
        calculator.mean([]).should == 0
      end

      it 'raises for nil values' do
        expect { calculator.mean([nil, 2]) }.to raise_error(/coerce/)
      end
    end

    describe '#mean_ignoring_nils' do
      let(:calculator) { ScoreCalculator.new({}, timestamp) }

      it 'returns mean of values given, not counting nils towards the amount of values' do
        calculator.mean_ignoring_nils([nil, 1, 2, 3, 4, 5, nil]).should == 3
      end

      it 'returns nil for empty array' do
        calculator.mean_ignoring_nils([]).should be_nil
      end

      it 'does not raise for nil values' do
        expect { calculator.mean_ignoring_nils([nil, 2]) }.not_to raise_error(/coerce/)
      end
    end

    describe '#mean_ignoring_nils_80_pct' do
      let(:calculator) { ScoreCalculator.new({}, timestamp) }

      it 'returns mean of values given, not counting nils towards the amount of values' do
        calculator.mean_ignoring_nils_80_pct([nil, 1, 2, 3, 4, 5, 6]).should == 3.5
      end

      it 'returns nil if the amount of nils > 20% of all values' do
        calculator.mean_ignoring_nils_80_pct([nil, 1, 2, 3, 4, 5, nil]).should be_nil
      end

      it 'returns nil for empty array' do
        calculator.mean_ignoring_nils_80_pct([]).should be_nil
      end

      it 'does not raise for nil values' do
        expect { calculator.mean_ignoring_nils_80_pct([nil, 2]) }.not_to raise_error(/coerce/)
      end
    end

    describe '#sum_extrapolate' do
      let(:calculator) { ScoreCalculator.new({}, timestamp) }

      it 'sums values given, taking nils to be the mean of the present values' do
        calculator.sum_extrapolate([1, 2, 3, 4, 5, nil], 5).should == 18
      end

      it 'returns nil if there are less values than minimum_present present (not nil)' do
        calculator.sum_extrapolate([nil, 1, 2], 3).should be_nil
      end
    end

    describe '#sum_extrapolate_80_pct' do
      let(:calculator) { ScoreCalculator.new({}, timestamp) }

      it 'sums values given, taking nils to be the mean of the present values' do
        calculator.sum_extrapolate_80_pct([1, 2, 3, 4, nil]).should == 12.5
      end

      it 'returns nil if there are less than 80% values present (not nil)' do
        calculator.sum_extrapolate_80_pct([1, 2, 3, nil, nil]).should be_nil
      end

      it 'rounds upwards if the result of 0.8*values.length is not round' do
        # 0.8*8 = 6.4
        calculator.sum_extrapolate_80_pct([1, 2, 3, 4, 5, 6, nil, nil]).should be_nil
        calculator.sum_extrapolate_80_pct([1, 2, 3, 4, 5, 6, 7, nil]).should == 32
      end
    end

    describe '#sum' do
      let(:calculator) { ScoreCalculator.new({}, timestamp) }

      it 'sums values given' do
        calculator.sum([1, 2, 3, 4]).should == 10
      end

      it 'sums no values' do
        calculator.sum([]).should == 0
      end

      it 'raises for nil values' do
        expect { calculator.sum([nil, 2]) }.to raise_error(/coerce/)
      end
    end

    describe '#age' do
      it 'returns the age' do
        calculator = ScoreCalculator.new({}, timestamp, {birthyear: 42.years.ago.year})
        calculator.age.should == 42
      end

      it 'returns the age when passed a string key' do
        calculator = ScoreCalculator.new({}, timestamp, {"birthyear" => 42.years.ago.year})
        calculator.age.should == 42
      end

      it 'calls the patient age accessor method with its timestamp' do
        calculator = ScoreCalculator.new({}, timestamp, {"birthyear" => 42.years.ago.year})
        calculator.instance_variable_get('@patient').should_receive(:age_at).with(timestamp)
        calculator.age
      end
    end

    describe '#gender' do
      it 'returns the gender' do
        calculator = ScoreCalculator.new({}, timestamp, {gender: :male})
        calculator.gender.should == :male
      end

      it 'returns the gender when passed a string key' do
        calculator = ScoreCalculator.new({}, timestamp, {"gender" => :male})
        calculator.gender.should == :male
      end

      it 'returns :unknown when gender is not given' do
        calculator = ScoreCalculator.new({}, timestamp, {})
        calculator.gender.should == :unknown
      end
    end

    describe '#score' do
      it 'returns the value of another score' do
        calculator = ScoreCalculator.new({}, timestamp, {}, {other: 1})
        calculator.score(:other).should == 1
      end

      it 'raises an exception when score is not known' do
        calculator = ScoreCalculator.new({}, timestamp, {}, {other: 1})
        expect { calculator.score(:missing) }.to raise_error(/does not exist or is not calculated/)
      end
    end

    describe '#require_percentage_filled' do
      let(:calculator) { ScoreCalculator.new({}, timestamp) }

      context 'when enough values are non-nil' do
        it 'returns the values' do
          calculator.require_percentage_filled([1, 2, 3, 4, 5, 6], 100).should == [1, 2, 3, 4, 5, 6]
        end

        it 'filters nils' do
          calculator.require_percentage_filled([1, 2, nil], 20).should == [1, 2]
        end

        it 'works with float percentages 0..1' do
          calculator.require_percentage_filled([1, 2, nil], 0.2).should == [1, 2]
        end
      end

      context 'when not enough values are non-nil' do
        it 'raises' do
          expect do
            calculator.require_percentage_filled([1, nil, nil, nil], 50)
          end.to raise_error("Needed at least 50.0% answered, got 25.0%")
        end
      end
    end

  end
end

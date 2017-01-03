require "spec_helper"

module Quby::Answers::Services
  include Quby::Questionnaires::Entities

  describe ScoreCalculator do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_1, type: :integer, title: 'Q1'
        question :v_2, type: :integer, title: 'Q2'
        question :v_3, type: :integer, title: 'Q3'
        question :v_4, type: :integer, title: 'Q4'
        question :v_5, type: :integer, title: 'Q5'

        question :v_6, type: :check_box do
          title 'Q6'
          option :v_6_a1, description: 'A1'
          option :v_6_a2, description: 'A2'
        end
      END
    end

    let(:timestamp) { Time.now }

    describe '.calculate' do
      let(:result) do
        ScoreCalculator.calculate(questionnaire, {'v_1' => 37, 'v_2' => 20}, timestamp) do
          {
            value: sum(values(:v_2, :v_1))
          }
        end
      end

      it 'calculates the value of a block' do
        expect(result[:value]).to eq(57)
      end

      it 'adds the list of referenced values, sorted by the order of the original values hash' do
        expect(result[:referenced_values]).to eq(%w(v_1 v_2))
      end
    end

    describe '#initialize' do
      it 'stores values passed' do
        calculator = ScoreCalculator.new(questionnaire, {v_1: 1}, timestamp, {gender: :male}, {score1: 2})
        calculator.instance_variable_get("@values").should eq({v_1: 1})
        calculator.instance_variable_get('@timestamp').should eq(timestamp)
        calculator.instance_variable_get("@patient").instance_variables
                  .should eq Quby::Answers::Entities::Patient.new(gender: :male).instance_variables
        calculator.instance_variable_get("@scores").should eq({score1: 2}.with_indifferent_access)
      end
    end

    describe '#ensure_answer_values_for', focus: true do
      let(:scores) { {'score1' => 22} }
      let(:calculator) { ScoreCalculator.new(questionnaire, values, timestamp, {}, scores) }

      subject { calculator.ensure_answer_values_for(keys) }
      let(:keys) { %w(v_1 v_2) }

      describe 'when the answer is nil' do
        let(:values) { {'v_1' => nil, 'v_2' => 4, 'v_3' => nil} }
        it { expect { subject }.to raise_error(Quby::Answers::Services::ScoreCalculator::MissingAnswerValues) }
      end

      describe 'when the answer is blank' do
        let(:values) { {'v_1' => '', 'v_2' => 4, 'v_3' => nil} }
        it { expect { subject }.to raise_error(Quby::Answers::Services::ScoreCalculator::MissingAnswerValues) }
      end

      describe 'when the answer is blank, but minimum_present is 0' do
        let(:values) { {'v_1' => '', 'v_2' => 4, 'v_3' => nil} }
        subject { calculator.ensure_answer_values_for(keys, minimum_present: 0) }
        it { expect { subject }.to_not raise_error }
      end

      describe 'when the answer is a missing string value' do
        let(:values) { {'v_1' => 'missing', 'v_2' => 4, 'v_3' => nil} }
        subject { calculator.ensure_answer_values_for(keys, missing_values: ['missing']) }
        it { expect { subject }.to raise_error(Quby::Answers::Services::ScoreCalculator::MissingAnswerValues) }
      end

      describe 'when the answer is a missing numeric value' do
        let(:values) { {'v_1' => 123, 'v_2' => 4, 'v_3' => nil} }
        subject { calculator.ensure_answer_values_for(keys, missing_values: [123]) }
        it { expect { subject }.to raise_error(Quby::Answers::Services::ScoreCalculator::MissingAnswerValues) }
      end

      describe 'when the answer is filled in with a string' do
        let(:values) { {'v_1' => 'abc', 'v_2' => 4, 'v_3' => nil} }
        it { expect { subject }.to_not raise_error }
      end

      describe 'when the answer is filled in with a number' do
        let(:values) { {'v_1' => 123, 'v_2' => 4, 'v_3' => nil} }
        it { expect { subject }.to_not raise_error }
      end
    end

    describe '#values' do
      let(:values) { {'v_1' => 1, 'v_2' => 4, 'v_3' => nil} }
      let(:scores) { {'score1' => 22} }
      let(:calculator) { ScoreCalculator.new(questionnaire, values, timestamp, {}, scores) }

      it 'returns the values hash if no args given' do
        calculator.values_with_nils.should eq values
      end

      it 'returns an array of values if args given' do
        calculator.values(:v_1, :v_2).should eq [values['v_1'], values['v_2']]
      end

      it 'finds values by string' do
        calculator.values('v_1').should eq [values['v_1']]
      end

      it 'annotates that the key for a value is referenced in this calculation' do
        calculator.values(:v_1, :v_2)
        expect(calculator.referenced_values).to eq(%w(v_1 v_2))
      end

      it 'annotates usage of keys when fetching all values' do
        calculator.values
        expect(calculator.referenced_values).to eq(%w(v_1 v_2 v_3))
      end

      it 'raises if a value is requested which does not exist' do
        expect do
          calculator.values(:unknown_key)
        end.to raise_error(ScoreCalculator::MissingAnswerValues)
      end

      it 'treats nil values the same as values of which the key does not exist' do
        expect do
          calculator.values(:v_3)
        end.to raise_error(ScoreCalculator::MissingAnswerValues)
      end
    end

    describe '#values_without_missings' do
      let(:values) { {'v_1' => 1, 'v_2' => 2, 'v_3' => nil, 'v_4' => nil} }
      let(:scores) { {'score1' => 22} }
      let(:calculator) { ScoreCalculator.new(questionnaire, values, timestamp, {}, scores) }

      it 'fails when called with no keys given' do
        expect { calculator.values_without_missings }.to raise_error(ArgumentError)
      end

      it 'returns the requested values that are not nil' do
        calculator.values_without_missings(:v_1, :v_3).should eq [values['v_1']]
      end

      it 'returns an array of values if args given' do
        calculator.values_without_missings(:v_1, :v_2).should eq [values['v_1'], values['v_2']]
      end

      it 'finds values by string' do
        calculator.values_without_missings('v_1').should eq [values['v_1']]
      end

      it 'annotates that the key for a value is referenced in this calculation' do
        calculator.values_without_missings(:v_1, :v_2)
        expect(calculator.referenced_values).to eq(%w(v_1 v_2))
      end

      it 'raises if too many requested values do not exist' do
        expect do
          calculator.values_without_missings(:unknown_key, minimum_present: 1)
        end.to raise_error(ScoreCalculator::MissingAnswerValues)
      end

      it 'treats nil values the same as values of which the key does not exist' do
        expect do
          calculator.values_without_missings(:v_3, minimum_present: 1)
        end.to raise_error(ScoreCalculator::MissingAnswerValues)
      end

      it 'treats missing_values the same as nil values' do
        expect do
          calculator.values_without_missings(:v_2, minimum_present: 1, missing_values: [2])
        end.to raise_error(ScoreCalculator::MissingAnswerValues)
      end
    end

    describe '#value' do
      let(:values) { {'v_1' => 1, 'v_2' => 4, 'v_3' => nil} }
      let(:scores) { {'score1' => 22} }
      let(:calculator) { ScoreCalculator.new(questionnaire, values, timestamp, {}, scores) }

      it 'returns the value for the provided argument key' do
        expect(calculator.value(:v_1)).to eq 1
      end

      it 'raises if a value is requested which does not exist' do
        expect do
          calculator.values(:v_3)
        end.to raise_error(ScoreCalculator::MissingAnswerValues)
      end
    end

    describe '#values_with_nils' do
      let(:values) { {'v_1' => 1, 'v_2' => 4, 'v_3' => nil, 'v_6_a2' => 1} }
      let(:scores) { {'score1' => 22} }
      let(:calculator) { ScoreCalculator.new(questionnaire, values, timestamp, {}, scores) }

      it 'returns the values hash if no args given' do
        calculator.values_with_nils.should eq values
      end

      it 'returns an array of values if args given' do
        calculator.values_with_nils(:v_1, :v_2).should eq [values['v_1'], values['v_2']]
      end

      it 'finds values by string' do
        calculator.values_with_nils('v_1').should eq [values['v_1']]
      end

      it 'annotates that the key for a value is referenced in this calculation' do
        calculator.values_with_nils(:v_1, :v_2)
        expect(calculator.referenced_values).to eq(%w(v_1 v_2))
      end

      it 'annotates usage of keys when fetching all values' do
        calculator.values_with_nils
        expect(calculator.referenced_values).to eq(%w(v_1 v_2 v_3 v_6_a2))
      end

      it 'returns nil if a value is requested which is not available' do
        calculator.values_with_nils(:v_3).should  eq [nil]
      end

      it 'raises if a value is requested more than once' do
        expect do
          calculator.values_with_nils(:v_1, 'v_1')
        end.to raise_error(/requested more than once/)
      end

      it 'does not miss checkbox values' do
        expect(calculator.values_with_nils(:v_6_a1, :v_6_a2)).to eq([nil, 1])
      end

      it 'raises if a value is requested that does not have a definition in the questionnaire' do
        expect do
          calculator.values_with_nils(:v_undefined)
        end.to raise_error(ScoreCalculator::UnknownFieldsReferenced)
      end
    end

    describe '#mean' do
      let(:calculator) { ScoreCalculator.new(questionnaire, {}, timestamp) }

      it 'returns mean of values given' do
        calculator.mean([1, 2, 3, 4, 5]).should eq 3
      end

      it 'returns a float value' do
        calculator.mean([2, 3]).should be_an_instance_of Float
      end

      it 'returns nil for empty array' do
        calculator.mean([]).should be_nil
      end

      it 'raises for nil values' do
        expect { calculator.mean([nil, 2]) }.to raise_error(/coerce/)
      end

      context 'with ignoring' do
        it 'ignores the given values' do
          expect(calculator.mean([2, 4, -1], ignoring: [-1])).to eq 3
          expect(calculator.mean([2, 4, -1], ignoring: [-1, 4])).to eq 2
        end

        it 'returns the same as an empty array when all values are ignored' do
          expect(calculator.mean([2, 4, -1], ignoring: [-1, 4, 2])).to eq calculator.mean([])
        end
      end
    end

    describe '#mean_ignoring_nils' do
      let(:calculator) { ScoreCalculator.new(questionnaire, {}, timestamp) }

      it 'returns mean of values given, not counting nils towards the amount of values' do
        calculator.mean_ignoring_nils([nil, 1, 2, 3, 4, 5, nil]).should eq 3
      end

      it 'returns nil for empty array' do
        calculator.mean_ignoring_nils([]).should be_nil
      end

      it 'does not raise for nil values' do
        expect { calculator.mean_ignoring_nils([nil, 2]) }.not_to raise_error
      end
    end

    describe '#mean_ignoring_nils_80_pct' do
      let(:calculator) { ScoreCalculator.new(questionnaire, {}, timestamp) }

      it 'returns mean of values given, not counting nils towards the amount of values' do
        calculator.mean_ignoring_nils_80_pct([nil, 1, 2, 3, 4, 5, 6]).should eq 3.5
      end

      it 'returns nil if the amount of nils > 20% of all values' do
        calculator.mean_ignoring_nils_80_pct([nil, 1, 2, 3, 4, 5, nil]).should be_nil
      end

      it 'returns nil for empty array' do
        calculator.mean_ignoring_nils_80_pct([]).should be_nil
      end

      it 'does not raise for nil values' do
        expect { calculator.mean_ignoring_nils_80_pct([nil, 2]) }.not_to raise_error
      end
    end

    describe '#sum_extrapolate' do
      let(:calculator) { ScoreCalculator.new(questionnaire, {}, timestamp) }

      it 'sums values given, taking nils to be the mean of the present values' do
        calculator.sum_extrapolate([1, 2, 3, 4, 5, nil], 5).should eq 18
      end

      it 'returns nil if there are less values than minimum_present present (not nil)' do
        calculator.sum_extrapolate([nil, 1, 2], 3).should be_nil
      end
    end

    describe '#sum_extrapolate_80_pct' do
      let(:calculator) { ScoreCalculator.new(questionnaire, {}, timestamp) }

      it 'sums values given, taking nils to be the mean of the present values' do
        calculator.sum_extrapolate_80_pct([1, 2, 3, 4, nil]).should eq 12.5
      end

      it 'returns nil if there are less than 80% values present (not nil)' do
        calculator.sum_extrapolate_80_pct([1, 2, 3, nil, nil]).should be_nil
      end

      it 'rounds upwards if the result of 0.8*values.length is not round' do
        # 0.8*8 = 6.4
        calculator.sum_extrapolate_80_pct([1, 2, 3, 4, 5, 6, nil, nil]).should be_nil
        calculator.sum_extrapolate_80_pct([1, 2, 3, 4, 5, 6, 7, nil]).should eq 32
      end
    end

    describe '#sum' do
      let(:calculator) { ScoreCalculator.new(questionnaire, {}, timestamp) }

      it 'sums values given' do
        calculator.sum([1, 2, 3, 4]).should eq 10
      end

      it 'sums no values' do
        calculator.sum([]).should eq 0
      end

      it 'raises for nil values' do
        expect { calculator.sum([nil, 2]) }.to raise_error(/coerce/)
      end
    end

    describe '#age' do
      it 'returns the age' do
        calculator = ScoreCalculator.new(questionnaire, {}, timestamp, {birthyear: 42.years.ago.year})
        calculator.age.should eq 42
      end

      it 'returns the age when passed a string key' do
        calculator = ScoreCalculator.new(questionnaire, {}, timestamp, {"birthyear" => 42.years.ago.year})
        calculator.age.should eq 42
      end

      it 'calls the patient age accessor method with its timestamp' do
        calculator = ScoreCalculator.new(questionnaire, {}, timestamp, {"birthyear" => 42.years.ago.year})
        calculator.instance_variable_get('@patient').should_receive(:age_at).with(timestamp)
        calculator.age
      end
    end

    describe '#gender' do
      it 'returns the gender' do
        calculator = ScoreCalculator.new(questionnaire, {}, timestamp, {gender: :male})
        calculator.gender.should eq :male
      end

      it 'returns the gender when passed a string key' do
        calculator = ScoreCalculator.new(questionnaire, {}, timestamp, {"gender" => :male})
        calculator.gender.should eq :male
      end

      it 'returns :unknown when gender is not given' do
        calculator = ScoreCalculator.new(questionnaire, {}, timestamp, {})
        calculator.gender.should eq :unknown
      end
    end

    describe '#score' do
      it 'returns the value of another score' do
        calculator = ScoreCalculator.new(questionnaire, {}, timestamp, {}, {other: 1})
        calculator.score(:other).should eq 1
      end

      it 'raises an exception when score is not known' do
        calculator = ScoreCalculator.new(questionnaire, {}, timestamp, {}, {other: 1})
        expect { calculator.score(:missing) }.to raise_error(/does not exist or is not calculated/)
      end
    end

    describe '#table_lookup' do
      let(:calculator) { ScoreCalculator.new(questionnaire, {}, timestamp, {}) }

      before do
        allow(Quby::LookupTable.backend_class).to receive(:new).and_return(double.as_null_object)
      end

      it 'instantiates a new Quby::Answers::Entities::LookupTable if the table_hash cache does not know the key' do
        expect(calculator.send :table_hash).to be_empty
        calculator.table_lookup :test_table, score: 1
        expect(calculator.send(:table_hash)[:test_table]).to be_a(Quby::LookupTable)
      end

      it 'uses the already instantiated lookuptable if there is a cache hit' do
        calculator.table_lookup :test_table, score: 1
        expect(calculator.send(:table_hash)[:test_table]).to receive(:lookup)
        calculator.table_lookup :test_table, score: 1
      end

      it 'looks up the given parameters on the given table' do
        parameters = {score: 1}
        expect_any_instance_of(Quby::LookupTable).to receive(:lookup).with parameters
        calculator.table_lookup :test_table, parameters
      end
    end

    describe 'when dealing with nil values' do
      it 'can be ignored, raising an error' do
        score = ScoreCalculation.new :som, label: "Somscore" do
          {value: sum(values(:v_1, :v_2, :v_3))}
        end
        expect { calculate(score, v_1: 3, v_2: 3, v_3: nil) }.to raise_error
      end

      it 'can be compacted' do
        score = ScoreCalculation.new :som, label: "Somscore" do
          {value: sum(values_with_nils(:v_1, :v_2, :v_3).compact)}
        end
        expect(calculate(score, v_1: 3, v_2: 3, v_3: nil)).to eq(value: 6, referenced_values: %w(v_1 v_2 v_3))
      end

      it 'can be extrapolated when enough values are present' do
        score = ScoreCalculation.new :som, label: "Somscore" do
          {value: sum_extrapolate(values_with_nils(:v_1, :v_2, :v_3), 2)}
        end
        expect(calculate(score, v_1: 3, v_2: 3, v_3: nil)).to eq(value: 9, referenced_values: %w(v_1 v_2 v_3))
      end

      it 'can be extrapolated when 80 percent is present' do
        score = ScoreCalculation.new :som, label: "Somscore" do
          {value: sum_extrapolate_80_pct(values_with_nils(:v_1, :v_2, :v_3, :v_4, :v_5))}
        end
        result = calculate(score, v_1: 3, v_2: 3, v_3: 3, v_4: 3, v_5: nil)
        expect(result).to eq(value: 15, referenced_values: %w(v_1 v_2 v_3 v_4 v_5))
      end

      def calculate(score, values = {})
        ScoreCalculator.calculate(questionnaire, values.stringify_keys, Time.now, {}, {}, &score.calculation)
      end
    end
  end
end

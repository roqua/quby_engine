# frozen_string_literal: true

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
        ScoreCalculator.calculate(questionnaire: questionnaire, values: {'v_1' => 37, 'v_2' => 20}, timestamp: timestamp) do
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
      let(:calculator) { ScoreCalculator.new(questionnaire: questionnaire, values: {'v_1' => 1}, timestamp: timestamp, patient_attrs: {gender: :male}) }

      it 'stores values passed' do
        expect(calculator.instance_variable_get("@values")).to eq 'v_1' => 1
        expect(calculator.instance_variable_get('@timestamp')).to eq(timestamp)
        expect(calculator.instance_variable_get("@patient").instance_variables)
          .to eq Quby::Answers::Entities::Patient.new(gender: :male).instance_variables
      end
    end

    describe '#ensure_answer_values_for' do
      let(:calculator) { ScoreCalculator.new(questionnaire: questionnaire, values: values, timestamp: timestamp) }
      let(:keys) { [:v_1, 'v_2'] }
      let(:values) { {'v_1' => '', 'v_2' => 4, 'v_3' => nil} }

      subject { calculator.ensure_answer_values_for(keys) }

      it 'allows access via list of key symbols' do
        expect { calculator.ensure_answer_values_for(:v_2) }.to_not raise_error
      end

      it 'allows a access via array of keys' do
        expect { calculator.ensure_answer_values_for([:v_2]) }.to_not raise_error
      end

      it 'allow access through key in strings' do
        expect { calculator.ensure_answer_values_for('v_2') }.to_not raise_error
      end

      describe 'when the answer is nil' do
        let(:values) { {'v_1' => nil, 'v_2' => 4, 'v_3' => nil} }
        it do
          expect { subject }.to(raise_error(Quby::Answers::Services::ScoreCalculator::MissingAnswerValues) do |error|
            expect(error.missing).to eq ['v_1'] # should always be strings.
            expect(error.values).to eq values
            expect(error.questionnaire_key).to eq 'test'
          end)
        end
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
      let(:calculator) { ScoreCalculator.new(questionnaire: questionnaire, values: values, timestamp: timestamp) }

      it 'returns the values hash if no args given' do
        expect(calculator.values_with_nils).to eq values
      end

      it 'returns an array of values if args given' do
        expect(calculator.values(:v_1, :v_2)).to eq [values['v_1'], values['v_2']]
      end

      it 'finds values by strings or symbols' do
        expect(calculator.values('v_1', :v_2)).to eq [values['v_1'], values['v_2']]
      end

      it 'finds values by array of strings or symbols' do
        expect(calculator.values([:v_1, 'v_2'])).to eq [values['v_1'], values['v_2']]
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
      let(:calculator) { ScoreCalculator.new(questionnaire: questionnaire, values: values, timestamp: timestamp) }

      it 'fails when called with no keys given' do
        expect { calculator.values_without_missings }.to raise_error(ArgumentError)
      end

      it 'returns the requested values that are not nil' do
        expect(calculator.values_without_missings(:v_1, :v_3)).to eq [values['v_1']]
      end

      it 'returns an array of values if args given' do
        expect(calculator.values_without_missings(:v_1, :v_2)).to eq [values['v_1'], values['v_2']]
      end

      it 'finds values by string or symbols' do
        expect(calculator.values_without_missings('v_1', :v_2)).to eq [values['v_1'], values['v_2']]
      end

      it 'finds values by array of strings or symbols' do
        expect(calculator.values_without_missings([:v_1, 'v_2'])).to eq [values['v_1'], values['v_2']]
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
      let(:calculator) { ScoreCalculator.new(questionnaire: questionnaire, values: values, timestamp: timestamp) }

      it 'returns the value by string or symbol' do
        expect(calculator.value(:v_1)).to eq 1
        expect(calculator.value('v_1')).to eq 1
      end

      it 'raises if a value is requested which does not exist' do
        expect do
          calculator.values(:v_3)
        end.to raise_error(ScoreCalculator::MissingAnswerValues)
      end
    end

    describe '#values_with_nils' do
      let(:values) { {'v_1' => 1, 'v_2' => 4, 'v_3' => nil, 'v_6_a2' => 1} }
      let(:calculator) { ScoreCalculator.new(questionnaire: questionnaire, values: values, timestamp: timestamp) }

      it 'returns the values hash if no args given' do
        expect(calculator.values_with_nils).to eq values
      end

      it 'returns an array of values if args given' do
        expect(calculator.values_with_nils(:v_1, :v_2)).to eq [values['v_1'], values['v_2']]
      end

      it 'finds values by string or symbol' do
        expect(calculator.values_with_nils('v_1', :v_2)).to eq [values['v_1'], values['v_2']]
      end

      it 'finds values by array of strings or symbols' do
        expect(calculator.values_with_nils(['v_1'])).to eq [values['v_1']]
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
        expect(calculator.values_with_nils(:v_3)).to eq [nil]
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
      let(:calculator) { ScoreCalculator.new(questionnaire: questionnaire, values: {}, timestamp: timestamp) }

      it 'returns mean of values given' do
        expect(calculator.mean([1, 2, 3, 4, 5])).to eq 3
      end

      it 'returns a float value' do
        expect(calculator.mean([2, 3])).to be_an_instance_of Float
      end

      it 'returns nil for empty array' do
        expect(calculator.mean([])).to be_nil
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
      let(:calculator) { ScoreCalculator.new(questionnaire: questionnaire, values: {}, timestamp: timestamp) }

      it 'returns mean of values given, not counting nils towards the amount of values' do
        expect(calculator.mean_ignoring_nils([nil, 1, 2, 3, 4, 5, nil])).to eq 3
      end

      it 'returns nil for empty array' do
        expect(calculator.mean_ignoring_nils([])).to be_nil
      end

      it 'does not raise for nil values' do
        expect { calculator.mean_ignoring_nils([nil, 2]) }.not_to raise_error
      end
    end

    describe '#mean_ignoring_nils_80_pct' do
      let(:calculator) { ScoreCalculator.new(questionnaire: questionnaire, values: {}, timestamp: timestamp) }

      it 'returns mean of values given, not counting nils towards the amount of values' do
        expect(calculator.mean_ignoring_nils_80_pct([nil, 1, 2, 3, 4, 5, 6])).to eq 3.5
      end

      it 'returns nil if the amount of nils > 20% of all values' do
        expect(calculator.mean_ignoring_nils_80_pct([nil, 1, 2, 3, 4, 5, nil])).to be_nil
      end

      it 'returns nil for empty array' do
        expect(calculator.mean_ignoring_nils_80_pct([])).to be_nil
      end

      it 'does not raise for nil values' do
        expect { calculator.mean_ignoring_nils_80_pct([nil, 2]) }.not_to raise_error
      end
    end

    describe '#sum_extrapolate' do
      let(:calculator) { ScoreCalculator.new(questionnaire: questionnaire, values: {}, timestamp: timestamp) }

      it 'sums values given, taking nils to be the mean of the present values' do
        expect(calculator.sum_extrapolate([1, 2, 3, 4, 5, nil], 5)).to eq 18
      end

      it 'returns nil if there are less values than minimum_present present (not nil)' do
        expect(calculator.sum_extrapolate([nil, 1, 2], 3)).to be_nil
      end
    end

    describe '#sum_extrapolate_80_pct' do
      let(:calculator) { ScoreCalculator.new(questionnaire: questionnaire, values: {}, timestamp: timestamp) }

      it 'sums values given, taking nils to be the mean of the present values' do
        expect(calculator.sum_extrapolate_80_pct([1, 2, 3, 4, nil])).to eq 12.5
      end

      it 'returns nil if there are less than 80% values present (not nil)' do
        expect(calculator.sum_extrapolate_80_pct([1, 2, 3, nil, nil])).to be_nil
      end

      it 'rounds upwards if the result of 0.8*values.length is not round' do
        # 0.8*8 = 6.4
        expect(calculator.sum_extrapolate_80_pct([1, 2, 3, 4, 5, 6, nil, nil])).to be_nil
        expect(calculator.sum_extrapolate_80_pct([1, 2, 3, 4, 5, 6, 7, nil])).to eq 32
      end
    end

    describe '#sum' do
      let(:calculator) { ScoreCalculator.new(questionnaire: questionnaire, values: {}, timestamp: timestamp) }

      it 'sums values given' do
        expect(calculator.sum([1, 2, 3, 4])).to eq 10
      end

      it 'sums no values' do
        expect(calculator.sum([])).to eq 0
      end

      it 'raises for nil values' do
        expect { calculator.sum([nil, 2]) }.to raise_error(/coerce/)
      end
    end

    describe '#age' do
      it 'returns the age' do
        calculator = ScoreCalculator.new(questionnaire: questionnaire, values: {}, timestamp: timestamp, patient_attrs: {birthyear: 42.years.ago.year})
        expect(calculator.age).to eq 42
      end

      it 'returns the age when passed a string key' do
        calculator = ScoreCalculator.new(questionnaire: questionnaire, values: {}, timestamp: timestamp, patient_attrs: {"birthyear" => 42.years.ago.year})
        expect(calculator.age).to eq 42
      end

      it 'calls the patient age accessor method with its timestamp' do
        calculator = ScoreCalculator.new(questionnaire: questionnaire, values: {}, timestamp: timestamp, patient_attrs: {"birthyear" => 42.years.ago.year})
        expect(calculator.instance_variable_get('@patient')).to receive(:age_at).with(timestamp)
        calculator.age
      end
    end

    describe '#gender' do
      it 'returns the gender' do
        calculator = ScoreCalculator.new(questionnaire: questionnaire, values: {}, timestamp: timestamp, patient_attrs: {gender: :male})
        expect(calculator.gender).to eq :male
      end

      it 'returns the gender when passed a string key' do
        calculator = ScoreCalculator.new(questionnaire: questionnaire, values: {}, timestamp: timestamp, patient_attrs: {"gender" => :male})
        expect(calculator.gender).to eq :male
      end

      it 'returns :unknown when gender is not given' do
        calculator = ScoreCalculator.new(questionnaire: questionnaire, values: {}, timestamp: timestamp, patient_attrs: {})
        expect(calculator.gender).to eq :unknown
      end
    end

    describe '#respondent_type' do
      it 'returns the respondent_type' do
        calculator = ScoreCalculator.new(questionnaire: questionnaire, values: {}, timestamp: timestamp, respondent_attrs: {respondent_type: :parent})
        expect(calculator.respondent_type).to eq :parent
      end

      it 'returns the respondent_type when passed a string key' do
        calculator = ScoreCalculator.new(questionnaire: questionnaire, values: {}, timestamp: timestamp, respondent_attrs: {"respondent_type" => :parent})
        expect(calculator.respondent_type).to eq :parent
      end

      it 'returns nil when respondent_type is not given' do
        calculator = ScoreCalculator.new(questionnaire: questionnaire, values: {}, timestamp: timestamp, respondent_attrs: {})
        expect(calculator.respondent_type).to eq nil
      end
    end

    describe '#score' do
      let(:questionnaire) do
        inject_questionnaire "test", <<-END
          question :v_1, type: :string

          variable :testvariable do
            "just a string"
          end

          score :test do
            {value: value(:v_1),
             other: gender}
          end

          score :test2 do
            gender = :fabulous
            {value: score(:test)[:other]}
          end
        END
      end
      let(:calculator) { ScoreCalculator.new(questionnaire: questionnaire, values: {'v_1' => '1'}, timestamp: timestamp) }

      it 'returns the value of another score' do
        expect(calculator.score(:test)).to eq(value: '1', other: :unknown)
        # and it also saves the referenced values of the called score to this calculator
        expect(calculator.referenced_values).to eq(['v_1'])
      end

      it 'does not transfer local variables into the score call' do
        expect(calculator.score(:test2)).to eq(value: :unknown)
      end

      it 'raises an exception when score is not known' do
        expect { calculator.score(:missing) }.to raise_error(/does not exist/)
      end

      it 'also returns variables' do
        expect(calculator.score(:testvariable)).to eq 'just a string'
      end
    end

    describe '#table_lookup' do
      let(:calculator) { ScoreCalculator.new(questionnaire: questionnaire, values: {}, timestamp: timestamp) }
      let(:table_double) { double.as_null_object }

      before do
        allow(Quby::LookupTable).to receive(:new).and_return(table_double)
      end

      it 'instantiates a new Quby::Answers::Entities::LookupTable if the table_hash cache does not know the key' do
        expect(questionnaire.lookup_tables).to be_empty
        calculator.table_lookup :test_table, score: 1
        expect(questionnaire.lookup_tables[:test_table]).to be(table_double)
      end

      it 'uses the memoized lookuptable if there is a cache hit' do
        calculator.table_lookup :test_table, score: 1
        expect(table_double).to receive(:lookup)
        calculator.table_lookup :test_table, score: 1
      end

      it 'looks up the given parameters on the given table' do
        parameters = {score: 1}
        expect(table_double).to receive(:lookup).with parameters
        calculator.table_lookup :test_table, parameters
      end

      context 'with add_lookup_tree inside dsl' do
        let(:questionnaire) do
          inject_questionnaire "test", <<-END
            add_lookup_tree :interpretations,
              levels: ['score', 'interpretation'],
              tree: {
                0..24 => 'low',
                25..50 => 'high'
              }

            score :test do
              {value: table_lookup(:interpretations, score: 26)}
            end
          END
        end

        it 'can use table_lookup inside scores' do
          expect(calculator.score(:test)).to eq(value: 'high')
        end
      end
    end

    describe 'when dealing with nil values' do
      it 'can be ignored, raising an error' do
        score = ScoreCalculation.new :som, label: "Somscore" do
          {value: sum(values(:v_1, :v_2, :v_3))}
        end
        expect { calculate(score, v_1: 3, v_2: 3, v_3: nil) }.to raise_error(Quby::Answers::Services::ScoreCalculator::MissingAnswerValues)
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
        ScoreCalculator.calculate(questionnaire: questionnaire, values: values.stringify_keys, timestamp: Time.now, &score.calculation)
      end
    end
  end
end

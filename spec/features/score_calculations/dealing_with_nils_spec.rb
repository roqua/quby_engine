require 'spec_helper'

module Quby
  describe 'Score calculations' do
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
    end

    def calculate(score, values = {})
      ScoreCalculator.calculate(values.stringify_keys, Time.now, {}, {}, &score.calculation)
    end
  end
end

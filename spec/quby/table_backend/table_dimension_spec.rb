# frozen_string_literal: true

require 'spec_helper'

describe Quby::TableBackend::TableDimension do
  describe 'described_class::AcceptsAnythingRange' do
    it 'always returns true on an include? call' do
      range = described_class::AcceptsAnythingRange.instance
      expect(range.include?(nil)).to eq(true)
      expect(range.include?(5)).to eq(true)
      expect(range.include?('aaa')).to eq(true)
      expect(range.include?(:aaa)).to eq(true)
    end
  end

  let(:accepts_anything_range) { described_class::AcceptsAnythingRange.instance }

  # a dimension tree of the following form
  # age: [0-10) -> gender: any -> [score_tscore: [0-5) = 3, [5-22) = 4,
  #                                score_tscore_klin: [0-3) = 16, [3-22) = 20]
  # age: [10-20) -> gender: m -> score_tscore: [0-3) = 6, [3-22) = 10
  let(:simple_tree) { described_class.new(:age, age_ranges) }
  let(:age_ranges) { {(0...10) => [gender_dimension1], (10...20) => [gender_dimension2]} }

  let(:gender_dimension1) { described_class.new(:gender, gender_range1) }
  let(:gender_range1) { {accepts_anything_range => [leaf_score_tscore1, leaf_score_tscore_klin]} }
  let(:gender_dimension2) { described_class.new(:gender, gender_range2) }
  let(:gender_range2) { {['m'] => [leaf_score_tscore2]} } # f is not defined

  let(:leaf_score_tscore1) { described_class.new(:score_tscore, leaf_score_tscore_ranges1) }
  let(:leaf_score_tscore_ranges1) { {(0...5) => 3, (5...22) => 4} }
  let(:leaf_score_tscore2) { described_class.new(:score_tscore, leaf_score_tscore_ranges2) }
  let(:leaf_score_tscore_ranges2) { {(0...3) => 6, (3...22) => 10} }
  let(:leaf_score_tscore_klin) { described_class.new(:score_tscore_klin, leaf_score_tscore_klin_ranges) }
  let(:leaf_score_tscore_klin_ranges) { {(0...3) => 16, (3...22) => 20} }

  describe '#lookup' do
    it 'recursively looks into the appropriate ranges for the parameters until it can return a result from a leaf' do
      expect(simple_tree.lookup gender: 'm', age: 5, score_tscore: 6).to eq(4)
      expect(simple_tree.lookup gender: 'f', age: 4, score_tscore: 4).to eq(3)
      expect(simple_tree.lookup gender: 'm', age: 15, score_tscore: 6).to eq(10)
      expect(simple_tree.lookup gender: 'm', age: 5, score_tscore_klin: 6).to eq(20)
    end

    skip 'raises exception explaining which parameter is outside of a range if applicable' do
      expect { simple_tree.lookup gender: 'm', age: 55, score: 6 }.to raise_exception('Parameter age is outside range')
    end

    it 'returns nil if a parameter falls outside a range' do
      expect(simple_tree.lookup gender: 'm', age: 55, score: 6).to eq(nil)
    end

    it 'returns nil if no leaf can be reached with the given parameters' do
      # no _klin scores exist for age 10+
      expect(simple_tree.lookup gender: 'm', age: 15, score_tscore_klin: 6).to eq(nil)
    end

    it 'ignores extra parameters if it can reach a result with less' do
      expect(simple_tree.lookup gender: 'm', age: 15, score_tscore: 6, bogus: 22).to eq(10)
    end
  end
end

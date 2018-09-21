# frozen_string_literal: true

require 'spec_helper'
module Quby
  describe RangeCategories do
    describe '#initialize' do
      it 'rejects single values and even numbers of parameters' do
        expected_error = "RangeCategories should be of the form (0, 'label 0-10', 10, 'label 10-20', 20)"
        expect { described_class.new 0 }.to raise_exception(expected_error)
        expect { described_class.new 0, 'label', 10, 'lobel' }.to raise_exception(expected_error)
      end
    end

    describe '#as_range_hash' do
      it 'returns a hash of ranges in float form to labels' do
        expected_categories = {(0.0...30.0) => "Zeer laag", (30.0...40.0) => "Laag", (40.0...60.0) => "Gemiddeld",
                               (60.0...70.0) => "Hoog", (70.0..100.0) => "Zeer hoog"} # last range should be inclusive
        range_caterories = described_class.new 0, 'Zeer laag',
                                               30, 'Laag',
                                               40, 'Gemiddeld',
                                               60, 'Hoog',
                                               70, 'Zeer hoog', 100
        expect(range_caterories.as_range_hash).to eq(expected_categories)
      end

      it 'works for a single range' do
        expected_categories = {(0.0..100.0) => "Zeer hoog"}
        range_caterories = described_class.new 0, 'Zeer hoog', 100
        expect(range_caterories.as_range_hash).to eq(expected_categories)
      end
    end
  end
end

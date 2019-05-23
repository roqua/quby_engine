# frozen_string_literal: true

require 'spec_helper'

module Quby::Answers::Entities
  describe Patient do
    describe '#age' do
      it 'calculates the age at the given timestamp' do
        patient = Patient.new(birthyear: 37.years.ago.year)
        expect(patient.age_at(10.years.ago)).to eq 27
      end

      it 'returns nil when the given timestamp is nil' do
        patient = Patient.new(birthyear: 37.years.ago.year)
        expect(patient.age_at(nil)).to be_nil
      end
    end

    describe '#gender' do
      it 'returns the gender' do
        patient = Patient.new(gender: :male)
        expect(patient.gender).to eq :male
      end
    end
  end
end

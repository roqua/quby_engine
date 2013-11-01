require_relative '../../../app/models/quby/patient'

module Quby
  describe Patient do
    describe '#age' do
      it 'calculates the age at the given timestamp' do
        patient = Patient.new(birthyear: 37.years.ago.year)
        patient.age_at(10.years.ago).should == 27
      end

      it 'returns nil when the given timestamp is nil' do
        patient = Patient.new(birthyear: 37.years.ago.year)
        patient.age_at(nil).should be_nil
      end
    end

    describe '#gender' do
      it 'returns the gender' do
        patient = Patient.new(gender: :male)
        patient.gender.should == :male
      end
    end
  end
end

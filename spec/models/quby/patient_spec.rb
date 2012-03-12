require_relative '../../../app/models/quby/patient'

module Quby
  describe Patient do
    describe '#age' do
      it 'calculates the age' do
        patient = Patient.new(:birthyear => 37.years.ago.year)
        patient.age.should == 37
      end
    end

    describe '#gender' do
      it 'returns the gender' do
        patient = Patient.new(:gender => :male)
        patient.gender.should == :male
      end
    end
  end
end

require 'spec_helper'

describe ValidatesAttribute do
  class Invalid
    include ActiveModel::Model
    attr_accessor :required
    validates :required, presence: true
  end

  let(:invalid_model) { Invalid.new }

  describe '#validates_attribute' do
    class TestValidatesAttributeClass
      include ActiveModel::Model
      include ValidatesAttribute

      attr_accessor :test1, :test2
      validates_attribute :test1, :test2
    end

    let(:test_class) do
      TestValidatesAttributeClass
    end

    it 'adds a `validates_attribute` class method to use inside activemodels' do
      expect do
        test_class
      end.to_not raise_exception
    end

    it 'runs validations for given attributes and composits their errors on the model' do
      errors = test_class.new(test1: invalid_model,
                              test2: invalid_model).tap(&:valid?).errors
      expect(errors.full_messages).to eq(["Test1 Required moet opgegeven zijn", "Test2 Required moet opgegeven zijn"])
    end

    it 'does not add errors when valid' do
      expect(test_class.new).to be_valid
    end

    it 'treats non validatable attributes as invalid' do
      subject = test_class.new(test1: 1000)
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to eq(["Test1 does not respond_to valid?"])
    end
  end

  describe '#validates_array_attribute' do
    class TestValidatesAttributeArrayClass
      include ActiveModel::Model
      include ValidatesAttribute

      attr_accessor :test1
      validates_array_attribute :test1
    end

    let(:test_class) do
      TestValidatesAttributeArrayClass
    end

    it 'adds a `validates_array_attribute` class method to use inside activemodels' do
      expect do
        test_class
      end.to_not raise_exception
    end

    it 'runs validations for given array attributes and composits their errors on the model' do
      errors = test_class.new(test1: [invalid_model, invalid_model]).tap(&:valid?).errors
      expect(errors.full_messages).to eq(["Test1 element #0 Required moet opgegeven zijn",
                                          "Test1 element #1 Required moet opgegeven zijn"])
    end

    it 'does not add errors when valid' do
      expect(test_class.new).to be_valid
    end

    it 'treats non validatable elements as invalid' do
      subject = test_class.new(test1: [1000])
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to eq(["Test1 element #0 does not respond_to valid?"])
    end
  end
end

require 'spec_helper'

describe Quby::ArrayAttributeValidValidator do
  class self::Invalid
    include ActiveModel::Model
    attr_accessor :required
    validates :required, presence: true
  end

  let(:invalid_model) { self.class::Invalid.new }

  class self::TestValidatesAttributeArrayClass
    include ActiveModel::Model

    attr_accessor :test1
    validates :test1, 'quby/array_attribute_valid': true
  end

  let(:test_class) do
    self.class::TestValidatesAttributeArrayClass
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

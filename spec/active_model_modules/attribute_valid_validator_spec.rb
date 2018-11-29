require 'spec_helper'

describe AttributeValidValidator do
  class self::Invalid
    include ActiveModel::Model
    attr_accessor :required
    validates :required, presence: true
  end

  let(:invalid_model) { self.class::Invalid.new }

  class self::TestValidatesAttributeClass
    include ActiveModel::Model

    attr_accessor :test1, :test2
    validates :test1, attribute_valid: true
    validates :test2, attribute_valid: true
  end

  let(:test_class) do
    self.class::TestValidatesAttributeClass
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

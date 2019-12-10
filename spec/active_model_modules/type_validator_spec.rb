require 'spec_helper'

describe Quby::TypeValidator do
  let(:cls) { Class.new() do
                include ActiveModel::Model
                def self.model_name; ActiveModel::Name.new(self, nil, "Cls"); end
                attr_accessor :key
                validates :key, 'quby/type': {is_a: Symbol}
              end }

  it 'fails if the attribute is not of the required class' do
    errors = cls.new(key: "hi").tap(&:valid?).errors
    expect(errors.full_messages).to eq(["Key Is not of type Symbol"])
  end

  it 'does not add errors when valid' do
    expect(cls.new key: :hi).to be_valid
  end
end

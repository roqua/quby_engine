class HashType < ActiveModel::Type::Value
  def cast(value)
    return super if value.kind_of?(Hash)
    return {} if value.nil?
    super
  end
end

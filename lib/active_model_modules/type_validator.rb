# validates :key, 'quby/type': {is_a: Symbol}
class Quby::TypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.is_a? options[:is_a]

    record.errors.add(attribute, "Is not of type #{options[:is_a]}")
  end
end

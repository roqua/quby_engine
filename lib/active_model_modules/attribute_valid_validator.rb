class Quby::AttributeValidValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?
    if value.respond_to?(:valid?)
      record.errors.add(attribute, value.errors.full_messages.join(', ')) unless value.valid?
    else
      record.errors.add(attribute, 'does not respond_to valid?')
    end
  end
end

class ArrayAttributeValidValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?
    value.each.with_index do |element, index|
      if element.respond_to?(:valid?)
        unless element.valid?
          record.errors.add(attribute, "element ##{index} #{element.errors.full_messages.join(', ')}")
        end
      else
        record.errors.add(attribute, "element ##{index} does not respond_to valid?")
      end
    end
  end
end

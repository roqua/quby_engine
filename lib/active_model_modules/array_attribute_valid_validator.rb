class ArrayAttributeValidValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    value&.each&.with_index do |element, index|
      if !element.respond_to?(:valid?)
        record.errors.add(attribute, "element ##{index} does not respond_to valid?")
      elsif !element.valid?
        record.errors.add(attribute, "element ##{index} #{element.errors.full_messages.join(', ')}")
      end
    end
  end
end

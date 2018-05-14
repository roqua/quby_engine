module ValidatesAttribute
  extend ActiveSupport::Concern

  included do
    mattr_accessor :validates_attribute_scalars, :validates_attribute_arrays do
      []
    end

    validate :validate_attributes_validator
  end

  class_methods do
    def validates_attribute(*names)
      self.validates_attribute_scalars += names
    end

    def validates_array_attribute(*names)
      self.validates_attribute_arrays += names
    end
  end

  private

  def validate_attributes_validator
    validates_attribute_scalars.each do |attribute_name|
      add_validates_attribute_errors_for(send(attribute_name), attribute_name)
    end

    validates_attribute_arrays.each do |attribute_name|
      attribute = send(attribute_name)
      next if attribute.blank?
      attribute.each.with_index do |element, index|
        add_validates_attribute_errors_for(element, "#{attribute_name} element ##{index}")
      end
    end
  end

  def add_validates_attribute_errors_for(object, attribute_name)
    return if object.blank?
    if object.respond_to?(:valid?)
      errors.add(attribute_name, object.errors.full_messages.join(', ')) unless object.valid?
    else
      errors.add(attribute_name, 'does not respond_to valid?')
    end
  end
end

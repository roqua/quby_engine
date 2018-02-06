module ValidatesAttribute
  extend ActiveSupport::Concern

  included do
    @attribute_names = nil
    @array_attribute_names = nil

    validate :attribute_validations
  end

  class_methods do
    attr_reader :attribute_names, :array_attribute_names

    def validates_attribute(*attribute_names)
      @attribute_names = attribute_names
    end

    def validates_array_attribute(*attribute_names)
      @array_attribute_names = attribute_names
    end
  end

  def attribute_validations
    self.class.attribute_names&.each do |attribute_name|
      add_errors_for(send(attribute_name), attribute_name)
    end

    self.class.array_attribute_names&.each do |attribute_name|
      attribute = send(attribute_name)
      if attribute.present?
        attribute.each.with_index do |element, index|
          add_errors_for(element, "#{attribute_name} element ##{index}")
        end
      end
    end
  end

  private

  def add_errors_for(object, attribute_name)
    if object.present?
      if object.respond_to?(:valid?)
        errors.add(attribute_name, object.errors.full_messages.join(', ')) unless object.valid?
      else
        errors.add(attribute_name, 'does not respond_to valid?')
      end
    end
  end
end

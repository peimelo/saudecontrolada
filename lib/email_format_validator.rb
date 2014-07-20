class EmailFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    return if value.blank?

    unless value =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
      object.errors.add(attribute, :invalid_format)
    end
  end
end
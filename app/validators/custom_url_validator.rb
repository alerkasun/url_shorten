class CustomUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.present? && value.is_a?(String) && value.match?(/\A#{URI::regexp(['http', 'https'])}\z/)
      record.errors.add(attribute, :invalid, message: "is not a valid URL")
    end
  end
end
class NotNilValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << I18n.t('errors.messages.nil') if value.nil?
  end
end

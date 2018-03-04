module Tickets
  class CreateParams
    include ActiveModel::Model

    attr_accessor(
      :ticket_type,
      :first_name,
      :last_name,
      :email,
      :fields
    )

    def initialize(args)
      super(args)
      self.fields = Array(fields).map { |field| FieldParams.new(field) }
    end

    validates :ticket_type, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    validates :fields, presence: true
    validate :fields_params

    def fields_params
      invalid_fields = fields.select { |field| field.invalid? }

      return if invalid_fields.empty?

      errors.add(:fields, invalid_fields.map(&:errors))
    end

    class FieldParams
      include ActiveModel::Model

      attr_accessor(
        :name,
        :value,
      )

      validates :name, presence: true
      validates :value, presence: true
    end
  end
end

module Orders
  class Params
    include ActiveModel::Model

    attr_accessor(
      :first_name,
      :last_name,
      :email,
      :payment_type,
      :date,
      :legal_entity,
      :company,
      :company_uid,
      :company_vat_uid,
      :country,
      :city,
      :zip,
      :address,
      :tickets
    )

    def initialize(args)
      super(args)
      self.tickets = Array(tickets).map { |ticket| TicketParams.new(ticket) }
      self.legal_entity = parse_legal_entity
    end

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    validates :payment_type, presence: true, inclusion: {in: Order.payment_types.keys}
    validates :date, presence: true
    validates :legal_entity, inclusion: {in: [true, false]}
    validates :company, presence: true, allow_blank: true
    validates :company_uid, presence: true, allow_blank: true
    validates :company_vat_uid, presence: true, allow_blank: true
    validates :country, presence: true, allow_blank: true
    validates :city, presence: true, allow_blank: true
    validates :zip, presence: true, allow_blank: true
    validates :address, presence: true, allow_blank: true
    validate :validate_date

    validates :tickets, presence: true
    validate :tickets_params

    def tickets_params
      invalid_tickets = tickets.select { |ticket| ticket.invalid? }

      return if invalid_tickets.empty?

      errors.add(:tickets, invalid_tickets.map(&:errors))
    end

    def validate_date
      return if date.nil?

      parsed_date = Time.zone.parse(date)

      if parsed_date < Time.zone.today
        errors.add(:date, "Date can't be in the past")
      end

      self.date = parsed_date
    rescue ArgumentError
      errors.add(:date, "Invalid date/date format")
    end

    def parse_legal_entity
      if %w(true false).include?(legal_entity)
        ActiveModel::Type::Boolean.new.cast(legal_entity)
      else
        legal_entity
      end
    end

    class TicketParams
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
end

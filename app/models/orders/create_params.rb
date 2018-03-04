module Orders
  class CreateParams
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
      self.tickets = Array(tickets).map { |ticket| Tickets::CreateParams.new(ticket) }
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
      parsed_date = Date.parse(date)

      if parsed_date < Time.zone.today
        errors.add(:date, "Date can't be in the past")
      end

      self.date = parsed_date
    rescue ArgumentError
      errors.add(:date, "Invalid date/date format")
    end
  end
end

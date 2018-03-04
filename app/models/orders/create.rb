module Orders
  class Create
    def initialize(params)
      @params = params
    end

    def run
      verify_params

      ActiveRecord::Base.transaction do
        order = create_order
        tickets = create_tickets(order)
        create_line_items(order, tickets)

        order
      end
    end

    private

    attr_reader :params

    def create_order
      Order.create!(
        uid: order_uid,
        first_name: params.first_name,
        last_name: params.last_name,
        email: params.email,
        payment_type: params.payment_type,
        date: params.date,
        legal_entity: params.legal_entity,
        company: params.company.to_s,
        company_uid: params.company_uid.to_s,
        company_vat_uid: params.company_vat_uid.to_s,
        country: params.country.to_s,
        city: params.city.to_s,
        zip: params.zip.to_s,
        address: params.address.to_s
      )
    end

    def create_tickets(order)
      params.tickets.map do |ticket_params|
        Ticket.create!(
          ticket_type: TicketType.find(ticket_params.ticket_type),
          uid: ticket_uid(ticket_params),
          first_name: ticket_params.first_name,
          last_name: ticket_params.last_name,
          email: ticket_params.email,
          fields: ticket_fields(ticket_params)
        )
      end
    end

    def ticket_fields(ticket_params)
      ticket_params.fields.map do |field|
        {
          name: field.name,
          value: field.value
        }
      end
    end

    def create_line_items(order, tickets)
      tickets.map do |ticket|
        LineItem.create!(
          ticket: ticket,
          order: order,
          price: ticket.ticket_type.price,
          quantity: 1,
          currency: ticket.ticket_type.currency
        )
      end
    end

    def ticket_uid(ticket_params)
      "#{params.date.strftime('%Y%m%d')}-#{ticket_initials(ticket_params)}-#{SecureRandom.uuid.first(2)}"
    end

    def ticket_initials(ticket_params)
      "#{ticket_params.first_name.first.upcase}#{ticket_params.last_name.first.upcase}"
    end

    def order_uid
      "#{params.date.strftime('%Y%m%d')}-#{order_initials}-#{SecureRandom.uuid.first(2)}"
    end

    def order_initials
      "#{params.first_name.first.upcase}#{params.last_name.first.upcase}"
    end

    def verify_params
      return if params.valid?

      raise ValidationError.new(params.errors)
    end
  end
end

class OrderSerializer < ApplicationSerializer
  attributes(
    :uid,
    :payment_type,
    :date,
    :first_name,
    :last_name,
    :email,
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

  def date
    object.date.to_date.iso8601
  end

  def tickets
    render_many(object.tickets, serializer: TicketSerializer[])
  end
end


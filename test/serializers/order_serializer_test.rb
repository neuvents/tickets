require 'test_helper'

class OrderSerializerTest < ActiveSupport::TestCase
  test 'serializes the order' do
    order = orders(:corporate)
    ticket = tickets(:first)
    LineItem.create!(
      order: order,
      ticket: ticket,
      quantity: 1,
      price: ticket.ticket_type.price,
      currency: ticket.ticket_type.currency
    )

    assert_json(
      OrderSerializer.new(order).to_json,
      {
        uid: order.uid,
        payment_type: order.payment_type,
        date: order.date.to_date.iso8601,
        first_name: order.first_name,
        last_name: order.last_name,
        email: order.email,
        legal_entity: order.legal_entity,
        company: order.company,
        company_uid: order.company_uid,
        company_vat_uid: order.company_vat_uid,
        country: order.country,
        city: order.city,
        zip: order.zip,
        address: order.address,
        tickets: [
          {
            uid: ticket.uid,
            first_name: ticket.first_name,
            last_name: ticket.last_name,
            email: ticket.email,
            fields: ticket.fields
          }
        ]
      }
    )
  end
end

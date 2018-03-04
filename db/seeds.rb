LineItem.destroy_all
Order.destroy_all
Ticket.destroy_all
TicketType.destroy_all
Event.destroy_all

event = Event.create!(
  name: "Balkan Ruby",
  active: true,
  description: "The annual ruby conference on the Balkan peninsula"
)

early_bird_tt = TicketType.create!(
  event: event,
  name: "Early bird",
  active: true,
  price: 8900,
  currency: "EUR",
  fields: [
    {
      type: "text",
      name: "t_shirt_size",
      label: "T-shirt size",
      required: true
    }
  ]
)

standard_tt = TicketType.create!(
  event: event,
  name: "Standard",
  active: true,
  price: 9900,
  currency: "EUR",
  fields: [
    {
      type: "text",
      name: "t_shirt_size",
      label: "T-shirt size",
      required: true
    }
  ]
)

ticket_one = Ticket.create!(
  uid: SecureRandom.uuid,
  ticket_type: early_bird_tt,
  first_name: "John",
  last_name: "Doe",
  email: "john@example.com",
  fields: [
    {
      name: "t_shirt_size",
      value: "L"
    }
  ]
)

ticket_two = Ticket.create!(
  uid: SecureRandom.uuid,
  ticket_type: standard_tt,
  first_name: "Jane",
  last_name: "Doe",
  email: "jane@example.com",
  fields: [
    {
      name: "t_shirt_size",
      value: "L"
    }
  ]
)

order = Order.create!(
  uid: SecureRandom.uuid,
  first_name: "John",
  last_name: "Doe",
  email: "john@example.com",
  payment_type: "credit_card",
  date: Time.current,
  legal_entity: true,
  company: "Aperture technologies",
  company_uid: "12345678",
  company_vat_uid: "BG12345678",
  country: "Bulgaria",
  city: "Sofia",
  zip: "1407",
  address: "ul. Banat 3"
)

LineItem.create!(
  order: order,
  ticket: ticket_one,
  quantity: 1,
  price: ticket_one.ticket_type.price,
  currency: ticket_one.ticket_type.currency
)

LineItem.create!(
  order: order,
  ticket: ticket_two,
  quantity: 1,
  price: ticket_two.ticket_type.price,
  currency: ticket_two.ticket_type.currency
)

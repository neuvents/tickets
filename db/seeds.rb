Ticket.destroy_all
TicketType.destroy_all
Event.destroy_all

event = Event.create!(
  uid: SecureRandom.uuid,
  name: "Balkan Ruby",
  active: true,
  description: "The annual ruby conference on the Balkan peninsula"
)

early_bird_tt = TicketType.create!(
  event: event,
  uid: SecureRandom.uuid,
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
  uid: SecureRandom.uuid,
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

Ticket.create!(
  ticket_type: early_bird_tt,
  uid: SecureRandom.uuid,
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

Ticket.create!(
  ticket_type: standard_tt,
  uid: SecureRandom.uuid,
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

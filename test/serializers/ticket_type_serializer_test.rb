require 'test_helper'

class TicketTypeSerializerTest < ActiveSupport::TestCase
  test 'serializes the ticket type' do
    ticket_type = ticket_types(:early_bird)

    assert_json(
      TicketTypeSerializer.new(ticket_type).to_json,
      {
        id: ticket_type.id,
        name: ticket_type.name,
        active: ticket_type.active,
        price: ticket_type.price,
        currency: ticket_type.currency,
        fields: ticket_type.fields
      }
    )
  end
end

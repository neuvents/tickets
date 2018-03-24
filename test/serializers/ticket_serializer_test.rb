require 'test_helper'

class TicketSerializerTest < ActiveSupport::TestCase
  test 'serializes the ticket' do
    ticket = tickets(:first)

    assert_json(
      TicketSerializer.new(ticket).to_json,
      {
        uid: ticket.uid,
        first_name: ticket.first_name,
        last_name: ticket.last_name,
        email: ticket.email,
        fields: ticket.fields
      }
    )
  end
end

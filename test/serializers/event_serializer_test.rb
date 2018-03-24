require 'test_helper'

class EventSerializerTest < ActiveSupport::TestCase
  test 'serializes the event' do
    event = events(:balkan_ruby)

    assert_json(
      EventSerializer.new(event).to_json,
      {
        name: event.name,
        id: event.id,
        active: event.active,
        description: event.description,
        ticket_types: event.ticket_types.map do |ticket_type|
          {
            id: ticket_type.id,
            name: ticket_type.name,
            active: ticket_type.active,
            price: ticket_type.price,
            currency: ticket_type.currency,
            fields: ticket_type.fields
          }
        end
      }
    )
  end
end

require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  def format_events(events)
    Array(events).map do |event|
      {
        id: event.id,
        name: event.name,
        active: event.active,
        description: event.description,
        ticket_types: event.ticket_types.map do |ticket_type|
          {
            name: ticket_type.name,
            id: ticket_type.id,
            active: ticket_type.active,
            price: ticket_type.price,
            currency: ticket_type.currency,
            fields: ticket_type.fields
          }
        end
      }
    end
  end

  test 'index should render all existing events' do
    expected_events = format_events events(:balkan_ruby)

    get events_url

    assert_response :success
    assert_json @response.body, expected_events
  end

  test 'show should render a single event' do
    event = events(:balkan_ruby)
    expected_event = format_events(event).first

    get event_url(event)

    assert_response :success
    assert_json @response.body, expected_event
  end
end

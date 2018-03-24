class EventSerializer < ApplicationSerializer
  attributes :name, :id, :active, :description, :ticket_types

  def ticket_types
    render_many(object.ticket_types, serializer: TicketTypeSerializer[])
  end
end


class CompleteEventSerializer < EventSerializer
  attributes :ticket_types

  def ticket_types
    render_many(object.ticket_types, serializer: TicketTypeSerializer[])
  end
end


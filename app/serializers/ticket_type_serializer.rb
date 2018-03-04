class TicketTypeSerializer < ApplicationSerializer
  attributes :name, :id, :active, :price, :currency, :fields
end

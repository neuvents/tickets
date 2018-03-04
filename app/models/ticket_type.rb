class TicketType < ApplicationRecord
  belongs_to :event
  has_many :tickets

  validates :event, presence: true
  validates :name, presence: true
  validates :active, inclusion: {in: [true, false]}
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :currency, presence: true # TODO: validation for inclusion in currencies list
  # TODO: validations for fields
end

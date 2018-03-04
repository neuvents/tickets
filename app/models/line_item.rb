class LineItem < ApplicationRecord
  belongs_to :ticket
  belongs_to :order

  validates :ticket, presence: true
  validates :order, presence: true
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :quantity, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :currency, presence: true # TODO: validation for inclusion in currencies list
end

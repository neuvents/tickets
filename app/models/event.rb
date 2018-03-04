class Event < ApplicationRecord
  has_many :ticket_types

  validates :name, presence: true
  validates :active, inclusion: {in: [true, false]}
  validates :description, presence: true
end

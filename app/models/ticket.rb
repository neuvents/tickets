class Ticket < ApplicationRecord
  belongs_to :ticket_type

  attr_readonly :uid

  validates :uid, presence: true
  validates :ticket_type, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true # TODO: Add format validation for the email
  # TODO: validations for fields
end

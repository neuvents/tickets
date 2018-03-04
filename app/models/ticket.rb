class Ticket < ApplicationRecord
  belongs_to :ticket_type

  validates :ticket_type, presence: true
  validates :uid, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true # TODO: Add format validation for the email
  # TODO: validations for fields
end

class Order < ApplicationRecord
  has_many :line_items
  has_many :tickets, through: :line_items

  attr_readonly :uid

  enum payment_type: {credit_card: 0, bank_transfer: 1}

  validates :uid, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true # TODO: Add format validation for the email
  validates :payment_type, inclusion: {in: payment_types.keys}
  validates :date, presence: true
  validates :legal_entity, inclusion: {in: [true, false]}
  validates :company, not_nil: true
  validates :company_uid, not_nil: true
  validates :company_vat_uid, not_nil: true
  validates :country, not_nil: true
  validates :city, not_nil: true
  validates :zip, not_nil: true
  validates :address, not_nil: true
end

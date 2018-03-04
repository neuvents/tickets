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
  validates :company, presence: true, allow_blank: true
  validates :company_uid, presence: true, allow_blank: true
  validates :company_vat_uid, presence: true, allow_blank: true
  validates :country, presence: true, allow_blank: true
  validates :city, presence: true, allow_blank: true
  validates :zip, presence: true, allow_blank: true
  validates :address, presence: true, allow_blank: true
end

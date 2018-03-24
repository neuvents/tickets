require 'test_helper'

module Orders
  class ParamsTest < ActiveSupport::TestCase
    def setup
      @input = {
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        payment_type: "credit_card",
        date: Time.zone.today.to_s,
        legal_entity: true,
        company: "Aperture technologies",
        company_uid: "12345678",
        company_vat_uid: "BG12345678",
        country: "Bulgaria",
        city: "Sofia",
        zip: "1407",
        address: "ul. Banat 3",
        tickets: [
          {
            ticket_type: ticket_types(:early_bird).id,
            first_name: "John",
            last_name: "Doe",
            email: "john@example.com",
            fields: [
              {
                name: "t_shirt_size",
                value: "L"
              }
            ]
          },
          {
            ticket_type: ticket_types(:standard).id,
            first_name: "Jane",
            last_name: "Doe",
            email: "jane@example.com",
            fields: [
              {
                name: "t_shirt_size",
                value: "L"
              }
            ]
          }
        ]
      }
    end

    test 'should be valid when all required data is present' do
      params = Params.new @input

      assert params.valid?
    end

    test 'should not be valid when first_name is missing' do
      params = Params.new @input
      params.first_name = nil

      assert_not params.valid?
      assert_not_nil params.errors[:first_name]
    end

    test 'should not be valid when last_name is missing' do
      params = Params.new @input
      params.last_name = nil

      assert_not params.valid?
      assert_not_nil params.errors[:last_name]
    end

    test 'should not be valid when email is missing' do
      params = Params.new @input
      params.email = nil

      assert_not params.valid?
      assert_not_nil params.errors[:email]
    end

    test 'should not be valid when payment_type is missing' do
      params = Params.new @input
      params.payment_type = nil

      assert_not params.valid?
      assert_not_nil params.errors[:payment_type]
    end

    test 'should not be valid when payment_type is wrong' do
      params = Params.new @input
      params.payment_type = 'bogus-payment-type'

      assert_not params.valid?
      assert_not_nil params.errors[:payment_type]
    end

    test 'should not be valid when date is missing' do
      params = Params.new @input
      params.date = nil

      assert_not params.valid?
      assert_not_nil params.errors[:date]
    end

    test 'should not be valid when date is in the past' do
      params = Params.new @input
      params.date = (Time.zone.today - 4).to_s

      assert_not params.valid?
      assert_not_nil params.errors[:date]
    end

    test 'should not be valid when legal_entity is missing' do
      params = Params.new @input
      params.legal_entity = nil

      assert_not params.valid?
      assert_not_nil params.errors[:legal_entity]
    end

    test 'should not be valid when legal_entity is invalid' do
      params = Params.new @input
      params.legal_entity = 'bla'

      assert_not params.valid?
      assert_not_nil params.errors[:legal_entity]
    end

    test 'should be valid when company is missing' do
      params = Params.new @input
      params.company = nil

      assert params.valid?
    end

    test 'should be valid when company_uid is missing' do
      params = Params.new @input
      params.company_uid = nil

      assert params.valid?
    end

    test 'should be valid when company_vat_uid is missing' do
      params = Params.new @input
      params.company_vat_uid = nil

      assert params.valid?
    end

    test 'should be valid when country is missing' do
      params = Params.new @input
      params.country = nil

      assert params.valid?
    end

    test 'should be valid when city is missing' do
      params = Params.new @input
      params.city = nil

      assert params.valid?
    end

    test 'should be valid when zip is missing' do
      params = Params.new @input
      params.zip = nil

      assert params.valid?
    end

    test 'should be valid when address is missing' do
      params = Params.new @input
      params.address = nil

      assert params.valid?
    end

    test 'should not be valid when tickets is missing' do
      @input[:tickets] = nil
      params = Params.new @input

      assert_not params.valid?
      assert_not_nil params.errors[:tickets]
    end

    test 'should not be valid when tickets are invalid' do
      @input[:tickets] = [{ticket_type: ticket_types(:early_bird).id}]

      params = Params.new @input

      assert_not params.valid?
      assert_not_nil params.errors[:tickets]
    end

    test 'should not be valid when the ticket fields are missing' do
      @input[:tickets] = [
        {
          ticket_type: ticket_types(:early_bird).id,
          first_name: "John",
          last_name: "Doe",
          email: "john@example.com",
          fields: nil
        }
      ]

      params = Params.new @input

      assert_not params.valid?
      assert_not_nil params.errors[:tickets]
    end

    test 'should not be valid when the ticket fields are invalid' do
      @input[:tickets] = [
        {
          ticket_type: ticket_types(:early_bird).id,
          first_name: "John",
          last_name: "Doe",
          email: "john@example.com",
          fields: [
            {name: 'field-name'}
          ]
        }
      ]

      params = Params.new @input

      assert_not params.valid?
      assert_not_nil params.errors[:tickets]
    end
  end
end

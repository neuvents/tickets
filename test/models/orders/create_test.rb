require 'test_helper'

module Orders
  class CreateTest < ActiveSupport::TestCase
    def test_time
      DateTime.new(2018, 3, 18, 20, 28, 34)
    end

    def setup
      @input = {
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        payment_type: "credit_card",
        date: test_time.to_s,
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

    test 'should create all necessary records when input is valid' do
      travel_to(test_time) do
        Create.new(Params.new(@input)).run

        order = Order.last

        assert order.uid.match /20180318-JD-/
        assert_equal 'John', order.first_name
        assert_equal 'Doe', order.last_name
        assert_equal 'john@example.com', order.email
        assert_equal 'credit_card', order.payment_type
        assert_equal test_time, order.date
        assert_equal true, order.legal_entity
        assert_equal 'Aperture technologies', order.company
        assert_equal '12345678', order.company_uid
        assert_equal 'BG12345678', order.company_vat_uid
        assert_equal 'Bulgaria', order.country
        assert_equal 'Sofia', order.city
        assert_equal '1407', order.zip
        assert_equal 'ul. Banat 3', order.address

        tickets = order.tickets.to_a

        assert_equal 2, tickets.size
        assert_equal 'John', tickets.first.first_name
        assert_equal 'Doe', tickets.first.last_name
        assert_equal 'john@example.com', tickets.first.email
        assert tickets.first.uid.match /20180318-JD-/

        assert_equal 'Jane', tickets.last.first_name
        assert_equal 'Doe', tickets.last.last_name
        assert_equal 'jane@example.com', tickets.last.email
        assert tickets.last.uid.match /20180318-JD-/

        assert_not_equal tickets.last.uid, tickets.first.uid

        line_items = order.line_items.to_a
        assert_equal 2, line_items.size
        assert tickets.include?(line_items.first.ticket)
        assert tickets.include?(line_items.last.ticket)
      end
    end

    test 'raises ValidationError when input is not valid' do
      @input = {}

      error = assert_raises ValidationError do
        Create.new(Params.new(@input)).run
      end

      assert_equal 422, error.code
      assert_equal 'ValidationError', error.message
      assert_not_empty error.errors
    end
  end
end

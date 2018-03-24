require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  def test_time
    DateTime.new(2018, 3, 18, 20, 28, 34)
  end

  def request_params
    {
      order: {
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
          }
        ]
      }
    }
  end

  test 'post create should render 204 on success' do
    travel_to(test_time) do
      post orders_url, params: request_params, headers: authorization_header

      assert_response :success
      # TODO: match the response body!
    end
  end

  test 'post create should render 422 on invalid input data' do
    travel_to(test_time) do
      params = request_params
      params[:order][:first_name] = nil

      post orders_url, params: params, headers: authorization_header

      assert_response :unprocessable_entity
      # TODO: match response body!
    end
  end
end

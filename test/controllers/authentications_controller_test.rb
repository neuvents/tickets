require 'test_helper'

class AuthenticationsControllerTest < ActionDispatch::IntegrationTest
  def create_user
    User.create!(email: 'auth-test-user@example.com', password: '12345678')
  end

  test 'should render 401 when a user does not exist' do
    post authentications_url, params: {email: 'non-existant-user'}

    assert_response :unauthorized
    assert_json @response.body, {error: 'Access denied'}
  end

  test 'should render 401 when a user password is incorrect' do
    user = create_user

    post authentications_url, params: {email: user.email, password: '12'}

    assert_response :unauthorized
    assert_json @response.body, {error: 'Access denied'}
  end

  test 'should render 200 when the user credentials are correct' do
    user = create_user

    post authentications_url, params: {email: user.email, password: user.password}

    assert_response :success
    assert_json @response.body, {jwt: Token.encode(sub: user.id)}
  end
end

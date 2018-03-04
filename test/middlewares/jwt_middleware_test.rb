# frozen_string_literal: true

require 'test_helper'

class JWTMiddlewareTest < ActiveSupport::TestCase
  test 'valid token leaves the claims in env["jwt.token"]' do
    travel_to DateTime.new(2018, 3, 4, 21, 0, 0, 'UTC').in_time_zone do
      jwt = Token.encode(exp: 1.month.from_now)
      env = Rack::MockRequest.env_for('example.com', 'HTTP_AUTHORIZATION' => "Bearer #{jwt}")

      JWTMiddleware.new(app).call(env)

      claims = env['jwt.token']

      assert_equal 1522875600, claims["exp"]
    end
  end

  test 'invalid token responds with 401' do
    env = Rack::MockRequest.env_for('example.com', 'HTTP_AUTHORIZATION' => 'Bearer x.x.x')

    status, _, body = JWTMiddleware.new(app).call(env)

    assert_equal 401, status
    assert_json body.last, code: :decode_error, fields: {}
  end

  test 'expired token responds with 403 with code of :expired_signature' do
    jwt = Token.encode(exp: 1.year.ago)
    env = Rack::MockRequest.env_for('example.com', 'HTTP_AUTHORIZATION' => "Bearer #{jwt}")

    status, _, body = JWTMiddleware.new(app).call(env)

    assert_equal 403, status
    assert_json body.last, code: :expired_signature, fields: {}
  end

  def app
    -> (_) { [200, {}, []] }
  end
end

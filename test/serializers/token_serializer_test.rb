require 'test_helper'

class TokenSerializerTest < ActiveSupport::TestCase
  test 'serializes the token for a user' do
    user = users(:first)

    assert_json(
      TokenSerializer.new(user).to_json,
      {jwt: Token.encode(sub: user.id)}
    )
  end
end

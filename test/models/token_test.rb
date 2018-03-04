require 'test_helper'

class TokenTest < ActiveSupport::TestCase
  test "decodes a JWT token string into claims" do
    claims = Token.decode(subject_42_token)

    assert_equal claims, "sub" => 42
  end

  test "encodes claims into JWT token string" do
    token = Token.encode sub: 42

    assert_equal subject_42_token, token
  end

  private

  def subject_42_token
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQyfQ.2OMUpCALOGkKWVCDwRmgQ3Mj_ToONCUgl5L12U1z3cE"
  end
end

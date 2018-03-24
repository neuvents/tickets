class TokenSerializer < ApplicationSerializer
  attributes :jwt

  def jwt
    Token.encode(sub: object.id)
  end
end

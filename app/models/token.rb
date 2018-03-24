module Token extend self
  cattr_accessor :secret
  cattr_accessor(:algorithm) { 'HS256' }

  def decode(token)
    JWT.decode(token, secret, true, {algorithm: algorithm}).first
  end

  def encode(claims)
    JWT.encode(normalize_claims(claims), secret, algorithm)
  end

  private

  def normalize_claims(claims)
    claims = claims.with_indifferent_access

    if expiry = claims['exp']
      claims['exp'] = Time.at(expiry.to_i).in_time_zone('UTC').to_i
    end

    claims
  end
end

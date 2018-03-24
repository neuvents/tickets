Rails.configuration.to_prepare do
  Token.secret = ENV['JWT_SECRET'] ||
    Rails.configuration.secret_key_base

  if algorithm = ENV['JWT_ALGORITHM'].presence
    Token.algorithm = algorithm
  end
end

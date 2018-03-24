module Testing
  module AuthenticationHelper
    def authorization_header
      user = User.create!(email: 'john@example.com', password: '12345678')
      token = Token.encode(sub: user.id)
      {'Authorization' => "Bearer #{token}"}
    end
  end
end

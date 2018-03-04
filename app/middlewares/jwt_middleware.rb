# frozen_string_literal: true

class JWTMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    if token = extract_token_from(env)
      begin
        env['jwt.token'] = Token.decode(token)
      rescue JWT::DecodeError => exc
        return ErrorResponse.from_exception(exc).to_a
      end
    end

    @app.call(env)
  end

  private

  def extract_token_from(env)
    env['HTTP_AUTHORIZATION'].to_s.match(/\ABearer (?<token>.*)\Z/) { |m| m[:token] }
  end

  ErrorResponse = Struct.new(:status, :code) do
    JWT_STATUS_CODE = Hash.new([401, :decode_error]).merge!(
      JWT::VerificationError  => [401, :verification_error],
      JWT::IncorrectAlgorithm => [401, :incorrect_algorithm],
      JWT::ExpiredSignature   => [403, :expired_signature],
      JWT::ImmatureSignature  => [403, :immature_signature],
      JWT::InvalidIssuerError => [403, :invalid_issuer],
      JWT::InvalidIatError    => [403, :invalid_iat],
      JWT::InvalidAudError    => [403, :invalid_aud],
      JWT::InvalidSubError    => [403, :invalid_sub],
      JWT::InvalidJtiError    => [403, :invalid_jti]
    )

    def self.from_exception(exc)
      new(*JWT_STATUS_CODE[exc.class])
    end

    def to_a
      [status, { 'Content-Type' => 'application/json' }, [{ code: code, fields: {} }.to_json]]
    end
  end
end

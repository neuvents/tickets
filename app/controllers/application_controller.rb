class ApplicationController < ActionController::API
  use JWTMiddleware

  before_action :authenticate

  rescue_from Error do |error|
    render json: {message: error.message}, status: error.code
  end

  rescue_from ValidationError do |error|
    render json: {errors: error.errors}, status: :unprocessable_entity
  end

  def current_user
    @current_user ||= User.find_by(id: claims["sub"])
  end

  private

  def authenticate
    render json: {error: 'Access denied'}, status: :unauthorized unless current_user
  end

  def claims
    request.env['jwt.token'] || {}
  end
end

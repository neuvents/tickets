class AuthenticationsController < ActionController::API
  def create
    if user.authenticate(params[:password])
      render json: user, serializer: TokenSerializer, location: nil
    else
      render_unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render_unauthorized
  end

  private

  def render_unauthorized
    render json: {error: 'Access denied'}, status: :unauthorized
  end

  def user
    User.find_by! email: params[:email]
  end
end

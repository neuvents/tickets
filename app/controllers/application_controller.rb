class ApplicationController < ActionController::API
  rescue_from Error do |error|
    render json: {error: error}, status: error.code
  end

  rescue_from ValidationError do |error|
    render json: {errors: error.errors}, status: :unprocessable_entity
  end
end

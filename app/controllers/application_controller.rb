class ApplicationController < ActionController::API
  def current_user
    @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
  end

  def authenticate_user
    render json: { error: "Unauthorized" }, status: :unauthorized unless current_user
  end
end

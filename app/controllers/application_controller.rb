class ApplicationController < ActionController::API
  def current_user
    @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
  end

  def authenticate_user
    render_error("Unauthorized", :unauthorized) unless current_user
  end

  def render_error(message, status = :unprocessable_entity)
    render json: { error: message }, status: status
  end
end

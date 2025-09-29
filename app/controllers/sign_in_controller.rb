# frozen_string_literal: true

class SignInController < ApplicationController
  def create
    user = User.authenticate_by(login: params[:login], password: params[:password])
    return render_error("Incorrect credentials", :unauthorized) unless user

    session[:current_user_id] = user.id
    render json: { status: 'success' }
  end

  def destroy
    session.delete(:current_user_id)

    render json: { status: 'success' }
  end
end

# frozen_string_literal: true

class StocksController < ApplicationController
  before_action :authenticate_user

  def buy
    BuyStocks.new(current_user.wallet, params[:symbol], params[:quantity]).call

    render json: { status: "success" }
  rescue StandardError => e
    render json: { error: e }, status: :unprocessable_entity
  end
end

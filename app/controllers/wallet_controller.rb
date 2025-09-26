# frozen_string_literal: true

class WalletController < ApplicationController
  before_action :authenticate_user

  def balance
    render json: { balance: current_user.wallet.balance }
  end
end

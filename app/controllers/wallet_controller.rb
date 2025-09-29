# frozen_string_literal: true

class WalletController < ApplicationController
  include WalletHelper

  before_action :authenticate_user
  before_action :find_walletable

  def balance
    wallet = @walletable.wallet
    render json: { id: wallet.id, balance: wallet.current_balance, currency: wallet.currency }
  end
end

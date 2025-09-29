# frozen_string_literal: true

class TransactionsController < ApplicationController
  include WalletHelper

  before_action :authenticate_user
  before_action :find_walletable

  def deposit
    DepositTransaction.new(@walletable.wallet.id, params[:sum]).call

    render json: { status: "success" }
  rescue StandardError => e
    render_error(e, :unprocessable_entity)
  end

  def withdraw
    WithdrawTransaction.new(@walletable.wallet.id, params[:sum]).call

    render json: { status: "success" }
  rescue StandardError => e
    render_error(e, :unprocessable_entity)
  end

  def transfer
    TransferTransaction.new(current_user.wallet, @walletable.wallet.id, params[:sum]).call

    render json: { status: "success" }
  rescue StandardError => e
    render_error(e, :unprocessable_entity)
  end
end

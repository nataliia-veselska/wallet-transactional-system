# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :authenticate_user

  def deposit
    DepositTransaction.new(params[:target_wallet_id], params[:sum]).call

    render json: { status: 'success' }
  rescue StandardError => e
    render json: { error: e }, status: :unprocessable_entity
  end

  def withdraw
    WithdrawTransaction.new(params[:source_wallet_id], params[:sum]).call

    render json: { status: 'success' }
  rescue StandardError => e
    render json: { error: e }, status: :unprocessable_entity
  end

  def transfer
    TransferTransaction.new(current_user.wallet, params[:target_wallet_id], params[:sum]).call

    render json: { status: 'success' }
  rescue StandardError => e
    render json: { error: e }, status: :unprocessable_entity
  end
end

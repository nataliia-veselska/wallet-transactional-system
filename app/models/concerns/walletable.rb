# frozen_string_literal: true

module Walletable
  extend ActiveSupport::Concern

  included do
    has_one :wallet, as: :walletable, dependent: :destroy

    after_create :create_wallet_if_needed
  end

  private

  def create_wallet_if_needed
    create_wallet! unless wallet
  end

  def create_wallet!(currency: "USD")
    create_wallet(currency: currency, balance_in_cents: 0.0)
  end
end

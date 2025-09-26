# frozen_string_literal: true

class Wallet < ActiveRecord::Base
  belongs_to :user
  has_many :deposits, inverse_of: :target_wallet, dependent: :destroy
  has_many :withdrawals, inverse_of: :source_wallet, dependent: :destroy

  validates :balance_in_cents, numericality: { greater_than_or_equal_to: 0 }

  def balance
    BigDecimal(balance_in_cents) / 100
  end

  def deposit(sum)
    return if sum <= 0

    update!(balance_in_cents: balance_in_cents + (sum * 100))
  end

  def withdraw(sum)
    return if sum <= 0 || sum > balance

    update!(balance_in_cents: balance_in_cents - (sum * 100))
  end
end

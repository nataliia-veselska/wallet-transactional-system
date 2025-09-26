# frozen_string_literal: true

class BaseTransaction
  private

  def create_deposit(source_wallet_id = nil)
    Deposit.create!(
      source_wallet_id:,
      target_wallet_id: target_wallet.id,
      sum_in_cents: sum * 100,
      status: 'pending'
    )
  end

  def create_withdraw(target_wallet_id = nil)
    Withdrawal.create!(
      source_wallet_id: source_wallet.id,
      target_wallet_id:,
      sum_in_cents: sum * 100,
      status: 'pending'
    )
  end
end

# frozen_string_literal: true

class TransferTransaction < BaseTransaction
  def initialize(source_wallet, target_wallet_id, sum)
    @source_wallet = source_wallet
    @target_wallet_id = target_wallet_id
    @sum = sum.to_i
  end

  attr_reader :source_wallet, :target_wallet_id, :sum

  def call
    validate_params

    deposit = create_deposit(source_wallet.id)
    withdrawal = create_withdraw(target_wallet_id)

    begin
    ActiveRecord::Base.transaction do
      source_wallet.withdraw(sum)
      target_wallet.deposit(sum)

      withdrawal.update!(status: "success")
      deposit.update!(status: "success")
    end
    rescue StandardError
      if deposit.pending? && withdrawal.pending?
        deposit.mark_as_failed
        withdrawal.mark_as_failed
        raise StandardError, "Couldn't perform the operation"
      end
    end
  end

  private

  def validate_params
    raise StandardError, "Invalid parameters" if target_wallet_id.blank? || sum.blank?
    raise StandardError, "Sum can't be 0 or less" if sum <= 0
    raise StandardError, "Wallet not found" unless target_wallet && source_wallet
    raise StandardError, "Insufficient balance" if sum > source_wallet.current_balance
  end

  def target_wallet
    @wallet ||= Wallet.find_by(id: target_wallet_id)
  end
end

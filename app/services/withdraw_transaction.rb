# frozen_string_literal: true

class WithdrawTransaction < BaseTransaction
  def initialize(source_wallet_id, sum)
    @source_wallet_id = source_wallet_id
    @sum = sum.to_i
  end

  attr_reader :source_wallet_id, :sum

  def call
    validate_params

    withdrawal = create_withdraw!

    begin
      ActiveRecord::Base.transaction do
        source_wallet.withdraw(sum)
        withdrawal.update!(status: "success")
      end
    rescue StandardError
      if withdrawal.pending?
        withdrawal.mark_as_failed
        raise StandardError, "Couldn't perform the operation"
      end
    end
  end

  private

  def validate_params
    raise StandardError, "Invalid parameters" if source_wallet_id.blank? || sum.blank?
    raise StandardError, "Sum can't be 0 or less" if sum <= 0
    raise StandardError, "Wallet not found" unless source_wallet
    raise StandardError, "Insufficient balance" if sum > source_wallet.current_balance
  end

  def source_wallet
    @source_wallet ||= Wallet.find_by(id: source_wallet_id)
  end
end

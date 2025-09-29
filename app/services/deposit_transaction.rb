# frozen_string_literal: true

class DepositTransaction < BaseTransaction
  def initialize(target_wallet_id, sum)
    @target_wallet_id = target_wallet_id
    @sum = sum.to_i
  end

  attr_reader :target_wallet_id, :sum

  def call
    validate_params

    deposit = create_deposit!

    begin
      ActiveRecord::Base.transaction do
        target_wallet.deposit(sum)
        deposit.update!(status: "success")
      end
    rescue StandardError
      if deposit.pending?
        deposit.mark_as_failed
        raise StandardError, "Couldn't perform the operation"
      end
    end
  end

  private

  def validate_params
    raise StandardError, "Invalid parameters" if target_wallet_id.blank? || sum.blank?
    raise StandardError, "Sum can't be 0 or less" if sum <= 0
    raise StandardError, "Wallet not found" unless target_wallet
  end

  def target_wallet
    @target_wallet ||= Wallet.find_by(id: target_wallet_id)
  end
end

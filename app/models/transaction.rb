# frozen_string_literal: true

class Transaction < ActiveRecord::Base
  belongs_to :source_wallet, class_name: "Wallet"
  belongs_to :target_wallet, class_name: "Wallet"

  validates :sum_in_cents, presence: true

  enum status: { success: "success", failure: "failure", pending: "pending" }
end

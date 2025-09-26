# frozen_string_literal: true

class Withdrawal < Transaction
  belongs_to :source_wallet, class_name: "Wallet"
  belongs_to :target_wallet, class_name: "Wallet", optional: true
end

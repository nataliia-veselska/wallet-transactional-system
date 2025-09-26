# frozen_string_literal: true

class Deposit < Transaction
  belongs_to :source_wallet, class_name: "Wallet", optional: true
  belongs_to :target_wallet, class_name: "Wallet"
end

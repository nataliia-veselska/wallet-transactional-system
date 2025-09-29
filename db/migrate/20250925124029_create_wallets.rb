class CreateWallets < ActiveRecord::Migration[7.2]
  def change
    create_table :wallets do |t|
      t.string :walletable_type, null: false
      t.bigint :walletable_id, null: false
      t.integer :balance_in_cents, default: 0
      t.string :currency, default: 'USD'

      t.timestamps
    end

    add_index :wallets, [:walletable_type, :walletable_id], unique: true
    add_index :wallets, :balance_in_cents
    add_index :wallets, :currency
  end
end

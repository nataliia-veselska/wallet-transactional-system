class CreateWallets < ActiveRecord::Migration[7.2]
  def change
    create_table :wallets do |t|
      t.references :user, foreign_key: true
      t.integer :balance_in_cents
      t.string :currency, default: 'USD'

      t.timestamps
    end
  end
end

class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.references :source_wallet, foreign_key: { to_table: :wallets }
      t.references :target_wallet, foreign_key: { to_table: :wallets }
      t.integer :sum_in_cents
      t.string :currency, default: 'USD'
      t.string :status
      t.string :type

      t.timestamps
    end
  end
end

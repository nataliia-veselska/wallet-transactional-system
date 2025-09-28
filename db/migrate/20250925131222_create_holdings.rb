class CreateHoldings < ActiveRecord::Migration[7.2]
  def change
    create_table :holdings do |t|
      t.references :user, foreign_key: true
      t.string :symbol
      t.integer :quantity
      t.integer :price_in_cents
      t.string :currency, default: 'USD'

      t.timestamps
    end
  end
end

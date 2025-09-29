class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.string :login
      t.string :password_digest

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :login, unique: true
  end
end

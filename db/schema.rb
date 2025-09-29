# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_09_25_131222) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "holdings", force: :cascade do |t|
    t.bigint "user_id"
    t.string "symbol"
    t.integer "quantity"
    t.integer "price_in_cents"
    t.string "currency", default: "USD"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["symbol"], name: "index_holdings_on_symbol"
    t.index ["user_id"], name: "index_holdings_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "source_wallet_id"
    t.bigint "target_wallet_id"
    t.integer "sum_in_cents"
    t.string "currency", default: "USD"
    t.string "status"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_wallet_id"], name: "index_transactions_on_source_wallet_id"
    t.index ["target_wallet_id"], name: "index_transactions_on_target_wallet_id"
    t.index ["type"], name: "index_transactions_on_type"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "email"
    t.string "login"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.string "walletable_type", null: false
    t.bigint "walletable_id", null: false
    t.integer "balance_in_cents", default: 0
    t.string "currency", default: "USD"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["balance_in_cents"], name: "index_wallets_on_balance_in_cents"
    t.index ["currency"], name: "index_wallets_on_currency"
    t.index ["walletable_type", "walletable_id"], name: "index_wallets_on_walletable_type_and_walletable_id", unique: true
  end

  add_foreign_key "holdings", "users"
  add_foreign_key "transactions", "wallets", column: "source_wallet_id"
  add_foreign_key "transactions", "wallets", column: "target_wallet_id"
end

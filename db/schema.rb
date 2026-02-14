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

ActiveRecord::Schema[8.1].define(version: 2026_02_14_180009) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "ceps", force: :cascade do |t|
    t.string "cep", limit: 10, null: false
    t.datetime "created_at", null: false
    t.bigint "neighborhood_id", null: false
    t.string "street", null: false
    t.datetime "updated_at", null: false
    t.index ["cep"], name: "index_ceps_on_cep", unique: true
    t.index ["neighborhood_id"], name: "index_ceps_on_neighborhood_id"
  end

  create_table "cities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "state_id", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "address_number", null: false
    t.date "birth_date"
    t.bigint "cep_id", null: false
    t.string "complement"
    t.datetime "created_at", null: false
    t.string "document_number", null: false
    t.string "document_type", null: false
    t.string "email"
    t.string "marital_status", default: "not_informed", null: false
    t.string "name", null: false
    t.string "nationality"
    t.string "phones", default: [], array: true
    t.string "profession"
    t.datetime "updated_at", null: false
    t.index ["cep_id"], name: "index_clients_on_cep_id"
    t.index ["document_number"], name: "index_clients_on_document_number", unique: true
  end

  create_table "contract_templates", force: :cascade do |t|
    t.text "content", null: false
    t.string "contract_type", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_contract_templates_on_name", unique: true
  end

  create_table "contracts", force: :cascade do |t|
    t.bigint "buyer_id"
    t.text "contract_content"
    t.string "contract_number", null: false
    t.bigint "contract_template_id"
    t.string "contract_type", null: false
    t.datetime "created_at", null: false
    t.date "end_date"
    t.text "notes"
    t.decimal "penalty_per_day", precision: 12, scale: 2, default: "0.0"
    t.bigint "property_id", null: false
    t.decimal "rental_commission", precision: 12, scale: 2, default: "0.0"
    t.decimal "rental_deposit", precision: 12, scale: 2, default: "0.0"
    t.integer "rental_due_day", default: 1
    t.decimal "rental_fee", precision: 12, scale: 2, default: "0.0"
    t.decimal "sale_commission", precision: 12, scale: 2, default: "0.0"
    t.decimal "sale_price", precision: 12, scale: 2, default: "0.0"
    t.bigint "seller_id", null: false
    t.date "signed_at"
    t.date "start_date"
    t.string "status", default: "active", null: false
    t.bigint "tenant_id"
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_contracts_on_buyer_id"
    t.index ["contract_number"], name: "index_contracts_on_contract_number", unique: true
    t.index ["contract_template_id"], name: "index_contracts_on_contract_template_id"
    t.index ["property_id"], name: "index_contracts_on_property_id"
    t.index ["seller_id"], name: "index_contracts_on_seller_id"
    t.index ["status"], name: "index_contracts_on_status"
    t.index ["tenant_id"], name: "index_contracts_on_tenant_id"
  end

  create_table "neighborhoods", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_neighborhoods_on_city_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.bigint "contract_id", null: false
    t.datetime "created_at", null: false
    t.text "notes"
    t.date "payment_date", null: false
    t.string "payment_method", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_payments_on_contract_id"
    t.index ["payment_date"], name: "index_payments_on_payment_date"
  end

  create_table "properties", force: :cascade do |t|
    t.string "address_number", null: false
    t.decimal "area", precision: 10, scale: 2
    t.bigint "cep_id", null: false
    t.decimal "commission_on_rentals", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "commission_on_sales", precision: 12, scale: 2, default: "0.0", null: false
    t.string "complement"
    t.datetime "created_at", null: false
    t.text "description"
    t.boolean "is_for_rent", default: false, null: false
    t.boolean "is_for_sale", default: true, null: false
    t.bigint "owner_id", null: false
    t.decimal "penalty_for_each_day_of_rent_overdue", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "rental_deposit", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "rental_fee", precision: 12, scale: 2, default: "0.0", null: false
    t.integer "rental_fee_due_day", default: 1, null: false
    t.decimal "sale_price", precision: 12, scale: 2, default: "0.0", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["cep_id"], name: "index_properties_on_cep_id"
    t.index ["owner_id"], name: "index_properties_on_owner_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "abbreviation", limit: 2, null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["abbreviation"], name: "index_states_on_abbreviation", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "is_active", default: true, null: false
    t.string "name", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "ceps", "neighborhoods"
  add_foreign_key "cities", "states"
  add_foreign_key "clients", "ceps"
  add_foreign_key "contracts", "clients", column: "buyer_id"
  add_foreign_key "contracts", "clients", column: "seller_id"
  add_foreign_key "contracts", "clients", column: "tenant_id"
  add_foreign_key "contracts", "contract_templates"
  add_foreign_key "contracts", "properties"
  add_foreign_key "neighborhoods", "cities"
  add_foreign_key "payments", "contracts"
  add_foreign_key "properties", "ceps"
  add_foreign_key "properties", "clients", column: "owner_id"
end

class CreateContracts < ActiveRecord::Migration[8.1]
  def change
    create_table :contracts do |t|
      t.string :contract_number, null: false
      t.references :property, null: false, foreign_key: true
      t.string :contract_type, null: false
      t.string :status, null: false, default: "active"

      # Parties involved
      t.references :seller, null: false, foreign_key: { to_table: :clients }
      t.references :buyer, foreign_key: { to_table: :clients }
      t.references :tenant, foreign_key: { to_table: :clients }

      # Dates
      t.date :signed_at
      t.date :start_date
      t.date :end_date

      # Sale-specific fields
      t.decimal :sale_price, precision: 12, scale: 2, default: 0.00
      t.decimal :sale_commission, precision: 12, scale: 2, default: 0.00

      # Rental-specific fields
      t.decimal :rental_fee, precision: 12, scale: 2, default: 0.00
      t.decimal :rental_deposit, precision: 12, scale: 2, default: 0.00
      t.decimal :rental_commission, precision: 12, scale: 2, default: 0.00
      t.integer :rental_due_day, default: 1
      t.decimal :penalty_per_day, precision: 12, scale: 2, default: 0.00

      t.references :contract_template, foreign_key: true
      t.text :contract_content
      t.text :notes

      t.timestamps
    end

    add_index :contracts, :contract_number, unique: true
    add_index :contracts, :status
  end
end

class CreateProperties < ActiveRecord::Migration[8.1]
  def change
    create_table :properties do |t|
      t.string :title, null: false
      t.text :description
      t.boolean :is_for_sale, null: false, default: true
      t.boolean :is_for_rent, null: false, default: false
      t.decimal :sale_price, precision: 12, scale: 2, null: false, default: 0.00
      t.decimal :commission_on_sales, precision: 12, scale: 2, null: false, default: 0.00
      t.decimal :rental_deposit, precision: 12, scale: 2, null: false, default: 0.00
      t.decimal :rental_fee, precision: 12, scale: 2, null: false, default: 0.00
      t.integer :rental_fee_due_day, null: false, default: 1
      t.decimal :penalty_for_each_day_of_rent_overdue, precision: 12, scale: 2, null: false, default: 0.00
      t.decimal :commission_on_rentals, precision: 12, scale: 2, null: false, default: 0.00
      t.decimal :area, precision: 10, scale: 2
      t.references :cep, null: false, foreign_key: true
      t.string :address_number, null: false
      t.string :complement
      t.references :owner, null: false, foreign_key: { to_table: :clients }

      t.timestamps
    end
  end
end

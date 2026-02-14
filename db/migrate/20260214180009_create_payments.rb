class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments do |t|
      t.references :contract, null: false, foreign_key: true
      t.decimal :amount, precision: 12, scale: 2, null: false
      t.date :payment_date, null: false
      t.string :payment_method, null: false
      t.text :notes

      t.timestamps
    end

    add_index :payments, :payment_date
  end
end

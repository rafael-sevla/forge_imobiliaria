class CreateClients < ActiveRecord::Migration[8.1]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :email
      t.string :phones, array: true, default: []
      t.string :document_type, null: false
      t.string :document_number, null: false
      t.string :nationality
      t.date :birth_date
      t.string :profession
      t.string :marital_status, null: false, default: "not_informed"
      t.references :cep, null: false, foreign_key: true
      t.string :address_number, null: false
      t.string :complement

      t.timestamps
    end

    add_index :clients, :document_number, unique: true
  end
end

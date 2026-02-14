class CreateCeps < ActiveRecord::Migration[8.1]
  def change
    create_table :ceps do |t|
      t.string :cep, limit: 10, null: false
      t.string :street, null: false
      t.references :neighborhood, null: false, foreign_key: true

      t.timestamps
    end

    add_index :ceps, :cep, unique: true
  end
end

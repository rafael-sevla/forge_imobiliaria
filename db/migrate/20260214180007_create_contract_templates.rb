class CreateContractTemplates < ActiveRecord::Migration[8.1]
  def change
    create_table :contract_templates do |t|
      t.string :name, null: false
      t.string :contract_type, null: false
      t.text :content, null: false

      t.timestamps
    end

    add_index :contract_templates, :name, unique: true
  end
end

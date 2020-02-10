class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :status_id, null: false
      t.integer :delivery_charge_id, null: false
      t.integer :ship_from_id, null: false
      t.integer :delivery_days_id, null: false
      t.integer :price, null: false
      t.references :category, null: false, foreign_key: true
    

      t.timestamps
    end
  end
end
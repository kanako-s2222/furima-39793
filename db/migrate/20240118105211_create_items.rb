class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :user,           null: false, foreign_key: true
      t.string :item_name,          null: false
      t.text :explain,              null: false
      t.integer :category_id,       null: false
      t.integer :condition_id,      null: false
      t.integer :delivery_price_id, null: false
      t.integer :place_id,          null: false
      t.integer :delivery_day_id,   null: false
      t.integer :price,             null: false

      t.timestamps
    end
  end
end

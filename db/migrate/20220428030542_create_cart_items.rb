class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.integer :quantity, default: 1
      t.integer :total, null: false
      t.integer :product_id, null: false
      t.integer :cart_id, null: false

      t.timestamps
    end
  end
end
